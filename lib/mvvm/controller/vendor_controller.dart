import '../const/export.dart';

class VendorFormController extends GetxController {
  final ApiManager _apiManager = ApiManager();

  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  // 👈 New: Observable list to store selected image files
  final RxList<File> selectedImages = <File>[].obs;
  final int maxImages = 5; // Set a limit for the number of images

  // 👈 New: Image Picker instance
  final ImagePicker _picker = ImagePicker();

  // 👈 New: Function to pick multiple images
  Future<void> pickImages() async {
    // Calculate how many more images can be added
    int remainingSlots = maxImages - selectedImages.length;

    // Only proceed if there are slots available
    if (remainingSlots > 0) {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        limit: remainingSlots,
        imageQuality: 70, // Adjust image quality as needed
      );

      if (pickedFiles.isNotEmpty) {
        // Convert XFile to File and add to the observable list
        for (var xFile in pickedFiles) {
          selectedImages.add(File(xFile.path));
        }
      }
    } else {
      CustomLoading.showNotification(
        message: "You can upload a maximum of $maxImages images.",
        messageType: MessageType.info,
      );
    }
  }

  // 👈 New: Function to remove an image
  void removeImage(File file) {
    selectedImages.remove(file);
  }

  @override
  void onInit() {
    super.onInit();
    fetchItems(isInitial: true);
  }

  @override
  void onClose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  var itemByCurrentUser = ItemForCurrentUser().obs;
  // 👈 New State for Edit/Update
  String? itemId = "";
  final RxList<String> existingImageUrls =
      <String>[].obs; // To hold existing image URLs
  final RxList<dynamic>? existingImageUrlsEdit =
      <dynamic>[].obs; // To hold existing image URLs
  final RxList<String> imagesToDelete =
      <String>[].obs; // To track images marked for deletion
  final RxString selectedType =
      'Ferramentas'.obs; // Initialize with a default value
  final RxString selectedTypeEdit =
      'Ferramentas'.obs; // Initialize with a default value
  var isCreateItemLoading = false.obs;

  // 👈 New: Remove existing image URL
  void removeExistingImage(String url) {
    // Add the URL to a list to be deleted on update
    imagesToDelete.add(url);
    // Remove it from the display list
    existingImageUrls.remove(url);
  }

  final nameControllerEdit = TextEditingController();
  final quantityControllerEdit = TextEditingController();
  final priceControllerEdit = TextEditingController();
  final descriptionControllerEdit = TextEditingController();

  void initializeWithItem(Item item) {
    // 1. Set the item ID for update/delete logic
    itemId = "${item.id}";

    // 2. Populate the TextControllers with the existing data
    nameControllerEdit.text = item.name ?? '';
    // Safely convert numerical properties to strings for text controllers
    quantityControllerEdit.text = item.quantity?.toString() ?? '';
    priceControllerEdit.text = item.price?.toString() ?? '';
    descriptionControllerEdit.text = item.description ?? '';

    selectedTypeEdit.value = item.type ?? "Ferramentas"; // Assuming a default

    // 4. Set the existing image URLs
    existingImageUrlsEdit?.clear();
    if (item.files != null) {
      existingImageUrlsEdit?.addAll(
        item.files?.map((e) => e.path).toList() ?? [],
      );
    }
  }

  final RxList<Item> itemList =
      <Item>[].obs; // To store the list of fetched items
  final RxInt currentPage = 1.obs; // Tracks the current page number
  final RxInt itemsPerPage =
      10.obs; // Sets the limit (e.g., 10 items per request)
  final RxBool isLoading = false.obs; // Tracks initial loading state
  final RxBool isPaginating =
      false.obs; // Tracks loading state for subsequent pages (load more)
  final RxBool hasMoreData =
      true.obs; // Indicates if there are more pages to load

  Future fetchItems({bool isInitial = false}) async {
    if (!hasMoreData.value && !isInitial) {
      return; // Stop if no more data is available
    }
    // Set loading state based on whether it's the first load or a "load more"
    if (isInitial) {
      isLoading.value = true;
      currentPage.value = 1; // Reset to page 1 for initial load/refresh
      itemList.clear(); // Clear list for initial load/refresh
      hasMoreData.value = true;
    } else {
      isPaginating.value = true;
    }

    try {
      final Map<String, String> params = {
        'page': currentPage.value.toString(),
        'per_page': itemsPerPage.value.toString(),
      };
      var response = await _apiManager.read(ApiUrl.itemByOwner, true, params);

      jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        itemByCurrentUser.value = ItemForCurrentUser.fromJson(data);
        final Set<int?> existingIds = itemList.map((item) => item.id).toSet();
        final List<Item> fetchedItems = itemByCurrentUser.value.items ?? [];

        final List<Item> uniqueNewItems = fetchedItems.where((item) {
          // <--- The error might be here!
          return item.id != null && !existingIds.contains(item.id);
        }).toList(); // <--- Or you forgot this part!
        final int totalPages =
            itemByCurrentUser.value.pagination?.lastPage ??
            1; // Adjust keys based on your API

        if (fetchedItems.isNotEmpty) {
          itemList.addAll(uniqueNewItems);
          // Increment page number for the next request
          currentPage.value++;
        }

        // Check if the current page is the last page
        if (currentPage.value > totalPages) {
          hasMoreData.value = false;
        }
      } else {
        // Handle API errors (e.g., 404, 500)
        CustomLoading.showNotification(
          message: 'Failed to load items.',
          messageType: MessageType.error,
        );
        hasMoreData.value =
            false; // Prevent further attempts if server error occurs
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Network error: $e',
        messageType: MessageType.error,
      );
    } finally {
      isLoading.value = false;
      isPaginating.value = false;
    }
  }

  // 2. Function to be called when the user scrolls to the bottom
  void loadNextPage() {
    if (!isLoading.value && !isPaginating.value && hasMoreData.value) {
      fetchItems();
    }
  }

  // 👈 Updated: Publish Item Logic
  Future<void> publishItem(dynamic context) async {
    // 1. Validation
    if (nameController.text.isEmpty ||
        quantityController.text.isEmpty ||
        priceController.text.isEmpty ||
        selectedType.isEmpty ||
        descriptionController.text.isEmpty) {
      CustomLoading.showNotification(
        message: 'Please fill in all fields.',
        messageType: MessageType.error,
      );
      return;
    }

    if (selectedImages.isEmpty) {
      CustomLoading.showNotification(
        message: 'Please upload at least one image.',
        messageType: MessageType.error,
      );
      return;
    }

    // Simple integer check for quantity and double check for price
    if (int.tryParse(quantityController.text) == null ||
        double.tryParse(priceController.text) == null) {
      CustomLoading.showNotification(
        message: 'Quantity and Price must be valid numbers.',
        messageType: MessageType.error,
      );
      return;
    }

    // 2. Prepare Data and Files
    final Map<String, String> data = {
      'name': nameController.text,
      'type': selectedType.value,
      'quantity': quantityController.text,
      'price': priceController.text,
      'description': descriptionController.text,
    };

    // 3. API Call
    try {
      // Show loading indicator (e.g., using Get.dialog or a loading overlay)
      isCreateItemLoading.value = true;
      FocusScope.of(context).unfocus();
      final response = await _apiManager.uploadMultipleFilesWithData(
        endpoint: ApiUrl.createItem, // Your endpoint
        files: selectedImages.toList(),
        data: data,
        fileField: 'images[]', // The array field name from your request example
        bearerToken: true,
      );
      isCreateItemLoading.value = false;

      // Handle response
      if (response.statusCode == 201) {
        nameController.clear();
        selectedImages.clear();
        quantityController.clear();
        priceController.clear();
        descriptionController.clear();
        // Successful upload
        Get.offNamed(AppRoutes.uploadSuccessScreen);
      } else {
        final responseBody = await response.stream.bytesToString();
        final message =
            jsonDecode(responseBody)['error']["message"] ??
            'Failed to publish item.';
        CustomLoading.showNotification(
          message: message,
          messageType: MessageType.error,
        );
      }
    } on Exception catch (e) {
      // 👈 CATCHES the Exception re-thrown by ApiManager (SocketException, TimeoutException, etc.)

      // e.toString() will contain the message like "Exception: No Internet connection..."
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      CustomLoading.showNotification(
        message: errorMessage,
        messageType: MessageType.error,
      );
    } catch (e) {
      isCreateItemLoading.value = false;

      CustomLoading.showNotification(
        message: 'An unexpected error occurred: ${e.toString()}',
        messageType: MessageType.error,
      );
    }
  }

  Future<void> updateItem(dynamic context, String slug) async {
    // 1. Validation
    // 1. --- Dynamic Data Payload and Change Detection ---
    final Map<String, String> data = {};

    if (nameControllerEdit.text.isNotEmpty) {
      data['name'] = nameControllerEdit.text;
    }
    if (quantityControllerEdit.text.isNotEmpty) {
      data['quantity'] = quantityControllerEdit.text;
    }
    if (priceControllerEdit.text.isNotEmpty) {
      data['price'] = priceControllerEdit.text;
    }
    if (descriptionControllerEdit.text.isNotEmpty) {
      data['description'] = descriptionControllerEdit.text;
    }

    data['type'] = selectedTypeEdit.value;

    // 2. --- Refined Validation ---

    // Check if NO fields were filled AND no new images were picked AND no images were marked for deletion.
    if (data.isEmpty && selectedImages.isEmpty && imagesToDelete.isEmpty) {
      CustomLoading.showNotification(
        message:
            'Please modify at least one field or image to update the item.',
        messageType: MessageType.error,
      );
      return;
    }

    // 3. API Call
    try {
      isCreateItemLoading.value = true;

      // The endpoint is correct for targeting an update using the slug.
      final response = await _apiManager.uploadMultipleFilesWithData(
        endpoint: "${ApiUrl.updateItem}$slug/update",
        files: selectedImages.toList(), // Only new files are sent here
        data: data, // Only sends modified fields and image deletion list
        fileField: 'images[]',
        bearerToken: true,
      );
      isCreateItemLoading.value = false;

      // Handle response
      if (response.statusCode == 200) {
        // Clear temporary states used for the edit session
        selectedImages.clear();
        // imagesToDelete.clear(); // assuming this list is still relevant if you handle removal elsewhere

        // 1. Clear the old list to ensure a full refresh
        itemList.clear();

        // 2. Fetch the new list data (await is crucial here)
        await fetchItems(isInitial: true);

        // 3. Show success notification
        CustomLoading.showNotification(
          message: 'Item updated successfully!',
          messageType: MessageType.success,
        );

        // 4. Navigate back to the item list screen (VenderScreen)
        // Get.back() closes the VendorEditScreen.
        Get.back();
      } else {
        final responseBody = await response.stream.bytesToString();
        final message =
            jsonDecode(responseBody)['error']["message"] ??
            'Failed to publish item.';
        CustomLoading.showNotification(
          message: message,
          messageType: MessageType.error,
        );
      }
    } on Exception catch (e) {
      // 👈 CATCHES the Exception re-thrown by ApiManager (SocketException, TimeoutException, etc.)

      // e.toString() will contain the message like "Exception: No Internet connection..."
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      CustomLoading.showNotification(
        message: errorMessage,
        messageType: MessageType.error,
      );
    } catch (e) {
      isCreateItemLoading.value = false;

      CustomLoading.showNotification(
        message: 'An unexpected error occurred: ${e.toString()}',
        messageType: MessageType.error,
      );
    }
  }
}
