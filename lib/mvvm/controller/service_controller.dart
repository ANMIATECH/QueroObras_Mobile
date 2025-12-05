import '../const/export.dart';

class ServiceController extends GetxController {
  final ApiManager _apiManager = ApiManager();
  RxList<dynamic> categories = <dynamic>[].obs;
  RxList<dynamic> cCategories = <dynamic>[].obs;
  RxList<dynamic> aCategories = <dynamic>[].obs;
  RxList providers = [].obs;
  var categoryName = ''.obs;
  RxList filteredProviders = [].obs;

  RxDouble myLat = 0.0.obs;
  RxDouble myLng = 0.0.obs;

  Future<void> getCurrentLocation() async {
    LocationPermission permission;

    // Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    if (permission == LocationPermission.denied) {
      throw Exception("User denied location permission.");
    }

    // Now get location safely
    await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    // print("Current location: ${position.latitude}, ${position.longitude}");
  }

  Future<double> calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng) /
        1000; // km
  }

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPopularServiceProvider();
    getCurrentLocation();
    getConstructionServiceProvider();
    getAcabamentoServiceProvider();
  }

  @override
  void onClose() {}

  Future<void> getPopularServiceProvider() async {
    try {
      var response = await _apiManager.read(ApiUrl.popularCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        categories.value = data["categories"] ?? [];
      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Failed to fetch categories";

        CustomLoading.showNotification(
          message: error,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> getConstructionServiceProvider() async {
    try {
      var response = await _apiManager.read(ApiUrl.constructionCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        cCategories.value = data["categories"] ?? [];
      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Failed to fetch categories";

        CustomLoading.showNotification(
          message: error,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  // 👈 New: Function to remove an image
  void removeImage(File file) {
    selectedImages.remove(file);
  }

  Future<void> getAcabamentoServiceProvider() async {
    try {
      var response = await _apiManager.read(ApiUrl.acabamentoCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        aCategories.value = data["categories"] ?? [];
      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Failed to fetch categories";

        CustomLoading.showNotification(
          message: error,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> getPopularServiceProviderBySlug(String slug) async {
    try {
      final url = "v1/category/$slug/users";

      var response = await _apiManager.read(url, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        providers.value = data["users"] ?? [];
        filteredProviders.value = List.from(providers);

        categoryName.value = data["category"]?["name"] ?? "";
      } else {
        var message = jsonDecode(response.body);
        var error = message["error"]?["message"] ?? "Failed to fetch providers";
        CustomLoading.showNotification(
          message: error,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  // 🔎 Search filter
  void filterProviders(String query) {
    if (query.isEmpty) {
      filteredProviders.value = providers;
    } else {
      filteredProviders.value = providers.where((provider) {
        final name = (provider['name'] ?? '').toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    }
  }

  final RxList<File> selectedImages = <File>[].obs;
  final int maxImages = 5; // Set a limit for the number of images
  final ImagePicker _picker = ImagePicker();
  var isCreateItemLoading = false.obs;

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

  final addressRequest = TextEditingController();
  final serviceToMake = TextEditingController();

  // 👈 Updated: Publish Item Logic
  Future<void> sendRequest(dynamic context, String serviceProviderId) async {
    // 1. Validation
    if (addressRequest.text.isEmpty || serviceToMake.text.isEmpty) {
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

    // 2. Prepare Data and Files
    final Map<String, String> data = {
      "service_provider_id": serviceProviderId,
      'address': addressRequest.text,
      'description': serviceToMake.text,
    };

    // 3. API Call
    try {
      // Show loading indicator (e.g., using Get.dialog or a loading overlay)
      isCreateItemLoading.value = true;
      FocusScope.of(context).unfocus();
      final response = await _apiManager.uploadMultipleFilesWithData(
        endpoint: ApiUrl.serviceRequests, // Your endpoint
        files: selectedImages.toList(),
        data: data,
        fileField: 'images[]', // The array field name from your request example
        bearerToken: true,
      );
      isCreateItemLoading.value = false;

      // Handle response
      if (response.statusCode == 201) {
        addressRequest.clear();
        serviceToMake.clear();
        // Successful upload
        CustomLoading.showNotification(
          message: "Request sent",
          messageType: MessageType.success,
        );
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
