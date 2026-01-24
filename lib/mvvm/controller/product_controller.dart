import 'package:queroobras_mobile/mvvm/const/export.dart';
import 'package:queroobras_mobile/mvvm/model/chat_model.dart';
import 'package:queroobras_mobile/mvvm/model/chat_one_on_one.dart';
import 'package:queroobras_mobile/mvvm/model/pay_order.dart';
import 'package:queroobras_mobile/mvvm/screens/dashboard/webview.dart';

class ProductDetailsController extends GetxController {
  RxInt quantity = 1.obs;

  final ApiManager _apiManager = ApiManager();
  @override
  void onInit() {
    super.onInit();
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      getCart();
      getAllOrders(isInitial: true);
      getAllOrdersRequest(isInitial: true);
      _startPolling();
    }

    getAllProduct(isInitial: true);
  }

  void incrementQuantity(num maxAllowedQuantity) {
    // We check if the current quantity is strictly less than the maximum limit.
    if (quantity.value < maxAllowedQuantity) {
      quantity.value++;
    } else {}
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  RxBool showFilters = true.obs;
  void toggleFilters() {
    showFilters.value = !showFilters.value;
  }

  // Inside ProductDetailsController
  final RxString searchTerm = ''.obs; // The user's current search input

  // 1. Master List (The complete list fetched from the API)
  final RxList<dynamic> masterItemList = <dynamic>[].obs;
  final RxList<dynamic> masterItemListOrder = <dynamic>[].obs;
  final RxList<dynamic> masterItemListOrderRequest = <dynamic>[].obs;
  var selectedLevelUpdateProduct = "".obs;

  void initializeWithItemTracking(String? dd) {
    selectedLevelUpdateProduct.value = dd ?? "packaging";
    // 1. Set the item ID for update/delete logic
  }

  void updateSearchTerm(String term) {
    // Update the search term immediately, which triggers the UI rebuild
    // because the UI is watching filteredItemList (which uses searchTerm).
    searchTerm.value = term;

    // No need for debouncing or calling getAllProduct() here unless you want to
    // reset the pagination when searching, but typically for client-side search,
    // you just filter what you have.
  }

  // 2. The List the UI will use (Computed filtered list)
  // We use a Getter for the UI list to automatically perform the filter logic.
  RxList<dynamic> get filteredItemList {
    if (searchTerm.value.isEmpty) {
      // If no search term, show the full list (which may contain paginated results)
      return masterItemList;
    }

    // Filter the master list based on the search term
    final lowerCaseSearchTerm = searchTerm.value.toLowerCase();

    return masterItemList
        .where((item) {
          // Assuming your Item objects have a 'name' field (adjust as needed)
          final name = item.name?.toLowerCase() ?? '';
          final type =
              item.type?.toLowerCase() ??
              ''; // Example of searching multiple fields

          return name.contains(lowerCaseSearchTerm) ||
              type.contains(lowerCaseSearchTerm);
        })
        .toList()
        .obs; // Convert to RxList and return
  }

  final product = ItemForCurrentUser().obs;
  final productOrder = OrderPayed().obs;
  final productOrderRequest = OrderPayed().obs;

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
  final RxList<Item> itemListOrder = <Item>[].obs;
  final RxBool hasMoreOrder = true.obs;
  final RxBool isLoadingOrder = false.obs;
  final RxInt currentPageOrder = 1.obs;

  final RxList<Item> itemListOrderRequest = <Item>[].obs;
  final RxBool hasMoreOrderRequest = true.obs;
  final RxBool isLoadingOrderRequest = false.obs;
  final RxInt currentPageOrderRequest = 1.obs;

  final RxBool isPaginatingOrder = false.obs;
  final RxBool isPaginatingOrderRequest = false.obs;
  final RxInt itemsPerPageOrder = 10.obs;
  final RxInt itemsPerPageOrderRequest = 10.obs;
  Future getAllProduct({bool isInitial = false}) async {
    if (!hasMoreData.value && !isInitial) return;

    if (isInitial) {
      isLoading.value = true;
      currentPage.value = 1;
      masterItemList.clear(); // Fresh start
      hasMoreData.value = true;
    } else {
      isPaginating.value = true;
    }

    try {
      final Map<String, String> params = {
        'page': currentPage.value.toString(),
        'per_page': itemsPerPage.value.toString(),
      };

      var response = await _apiManager.read(ApiUrl.getProduct, false, params);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        product.value = ItemForCurrentUser.fromJson(data);

        final List<Item> fetchedItems = product.value.items ?? [];
        final int totalPages = product.value.pagination?.lastPage ?? 1;

        if (fetchedItems.isNotEmpty) {
          // 1. De-duplication Logic using a Map (Key is ID)
          // This ensures if an ID already exists, it gets overwritten/ignored rather than duplicated
          final Map<int, Item> itemMap = {
            for (var item in masterItemList) item.id!: item,
          };

          for (var newItem in fetchedItems) {
            itemMap[newItem.id!] = newItem;
          }

          // 2. Convert back to list
          List<Item> uniqueList = itemMap.values.toList();

          // 3. Sorting Logic: Newest or most recently updated first
          uniqueList.sort((a, b) {
            final dateA = a.updatedAt ?? DateTime(0);
            final dateB = b.updatedAt ?? DateTime(0);
            return dateB.compareTo(dateA); // Descending order
          });

          // 4. Update the observable list
          masterItemList.assignAll(uniqueList);

          currentPage.value++;
        }

        // Check if we reached the end
        if (currentPage.value > totalPages) {
          hasMoreData.value = false;
        }
      } else {
        CustomLoading.showNotification(
          message: 'Falha ao carregar os itens',
          messageType: MessageType.error,
        );
        hasMoreData.value = false;
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    } finally {
      isLoading.value = false;
      isPaginating.value = false;
    }
  }

  Future getAllOrders({bool isInitial = false}) async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    if (!hasMoreOrder.value && !isInitial) {
      return; // Stop if no more data is available
    }
    // Set loading state based on whether it's the first load or a "load more"
    if (isInitial) {
      isLoadingOrder.value = true;
      currentPageOrder.value = 1; // Reset to page 1 for initial load/refresh
      itemListOrder.clear(); // Clear list for initial load/refresh
      hasMoreOrder.value = true;
    } else {
      isPaginatingOrder.value = true;
    }

    try {
      final Map<String, String> params = {
        'page': currentPageOrder.value.toString(),
        'per_page': itemsPerPageOrder.value.toString(),
      };

      var response = await _apiManager.read(ApiUrl.orders, true, params);

      jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        productOrder.value = OrderPayed.fromJson(data);

        final List<DataItemPayOrder> fetchedItems =
            productOrder.value.data?.items ?? [];
        final int totalPages =
            productOrder.value.data?.lastPage ??
            1; // Adjust keys based on your API

        if (fetchedItems.isNotEmpty) {
          // itemList.addAll(fetchedItems);
          masterItemListOrder.addAll(fetchedItems);

          // Increment page number for the next request
          currentPageOrder.value++;
        }

        // Check if the current page is the last page
        if (currentPageOrder.value > totalPages) {
          hasMoreOrder.value = false;
        }
      } else {
        // Handle API errors (e.g., 404, 500)
        CustomLoading.showNotification(
          message: 'Falha ao carregar os itens',
          messageType: MessageType.error,
        );
        hasMoreOrder.value =
            false; // Prevent further attempts if server error occurs
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    } finally {
      isLoadingOrder.value = false;
      isPaginatingOrder.value = false;
    }
  }

  Future getAllOrdersRequest({bool isInitial = false}) async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    if (!hasMoreOrderRequest.value && !isInitial) {
      return; // Stop if no more data is available
    }
    // Set loading state based on whether it's the first load or a "load more"
    if (isInitial) {
      isLoadingOrderRequest.value = true;
      currentPageOrderRequest.value =
          1; // Reset to page 1 for initial load/refresh
      itemListOrderRequest.clear(); // Clear list for initial load/refresh
      hasMoreOrderRequest.value = true;
    } else {
      isPaginatingOrderRequest.value = true;
    }

    try {
      final Map<String, String> params = {
        'page': currentPageOrderRequest.value.toString(),
        'per_page': itemsPerPageOrderRequest.value.toString(),
      };

      var response = await _apiManager.read(ApiUrl.orderSeller, true, params);

      jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        productOrderRequest.value = OrderPayed.fromJson(data);

        final List<DataItemPayOrder> fetchedItems =
            productOrderRequest.value.data?.items ?? [];
        final int totalPages =
            productOrderRequest.value.data?.lastPage ??
            1; // Adjust keys based on your API

        if (fetchedItems.isNotEmpty) {
          // itemList.addAll(fetchedItems);
          masterItemListOrderRequest.addAll(fetchedItems);

          // Increment page number for the next request
          currentPageOrderRequest.value++;
        }

        // Check if the current page is the last page
        if (currentPageOrderRequest.value > totalPages) {
          hasMoreOrderRequest.value = false;
        }
      } else {
        // Handle API errors (e.g., 404, 500)
        CustomLoading.showNotification(
          message: 'Falha ao carregar os itens',
          messageType: MessageType.error,
        );
        hasMoreOrderRequest.value =
            false; // Prevent further attempts if server error occurs
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    } finally {
      isLoadingOrderRequest.value = false;
      isPaginatingOrderRequest.value = false;
    }
  }

  // 2. Function to be called when the user scrolls to the bottom
  void loadNextPage() {
    if (!isLoading.value && !isPaginatingOrder.value && hasMoreData.value) {
      getAllProduct();
    }
  }

  void loadNextPageOrder() {
    if (!isLoadingOrder.value && !isPaginating.value && hasMoreOrder.value) {
      getAllOrders();
    }
  }

  void loadNextPageOrderRequest() {
    if (!isLoadingOrderRequest.value &&
        !isPaginatingOrderRequest.value &&
        hasMoreOrderRequest.value) {
      getAllOrdersRequest();
    }
  }

  Future<void> addToCart({required String itemSlug}) async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {
      var data = {'item_slug': itemSlug, 'quantity': "${quantity.value}"};
      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.addToCart, data, true);
      isLoading.value = false;
      print(response.body);
      if (response.statusCode == 200) {
        await getCart();
        CustomLoading.showNotification(
          message: 'item adicionado ao carrinho',
          messageType: MessageType.success,
        );
      } else {
        CustomLoading.showNotification(
          message: 'Falha ao adicionar ao carrinho.',
          messageType: MessageType.error,
        );
        print(response.body);
      }
    } catch (e) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    }
  }

  var loadStatusBtn = false.obs;
  Future<void> updateOrderStatus({required String itemSlug}) async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {
      var data = {'status': selectedLevelUpdateProduct.value};
      loadStatusBtn.value = true;
      var response = await _apiManager.post(
        "${ApiUrl.orderItem}/$itemSlug/status",
        data,
        true,
      );
      loadStatusBtn.value = false;

      if (response.statusCode == 200) {
        await getAllOrdersRequest(isInitial: true);
        CustomLoading.showNotification(
          message: 'Atualizado com sucesso',
          messageType: MessageType.success,
        );
        Get.back();
        Get.back();
      } else {
        CustomLoading.showNotification(
          message: 'Não consigo atualizar',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      loadStatusBtn.value = false;

      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    }
  }

  Future<void> checkoutChart() async {
    try {
      if (StorageDesign.validKey(StorageDesign.token) == false) {
        return;
      }
      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.cartCheckout, {}, true);
      isLoading.value = false;
      var decode = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.to(() => WebViewScreen(url: '${decode["checkout_url"]}'));
        await getCart();
      } else {
        CustomLoading.showNotification(
          message: 'Não foi possível obter o link de pagamento..',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    }
  }

  Future<void> removeFromCart({required String itemSlug}) async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {
      var response = await _apiManager.delete("${ApiUrl.cart}/$itemSlug", true);

      if (response.statusCode == 200) {
        await getCart();
        CustomLoading.showNotification(
          message: 'Item removido do carrinho.',
          messageType: MessageType.success,
        );
      } else {
        CustomLoading.showNotification(
          message: 'Falha ao remover o item do carrinho.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    }
  }

  var cart = CartModel().obs;

  Future<void> getCart() async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }

    try {
      var response = await _apiManager.read(ApiUrl.cart, true);

      if (response.statusCode == 200) {
        var date = jsonDecode(response.body);

        cart.value = CartModel.fromJson(date);
      } else {
        CustomLoading.showNotification(
          message: 'Falha ao obter o carrinho.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    }
  }

  var chatModel = ChatData().obs;
  Timer? timer;
  void _startPolling() {
    // Refresh every 10 seconds
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getAllChat();
    });
  }

  Future<void> getAllChat() async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {
      var response = await _apiManager.read(ApiUrl.getAllChat, true);

      if (response.statusCode == 200) {
        var date = jsonDecode(response.body);
        var fetchedData = ChatData.fromJson(date);

        // SORTING LOGIC: Handle the null safety here
        fetchedData.data?.sort((a, b) {
          final dateA = a.updatedAt ?? DateTime(0);
          final dateB = b.updatedAt ?? DateTime(0);
          return dateB.compareTo(dateA); // Newest first
        });

        chatModel.value = fetchedData;
      } else {
        CustomLoading.showNotification(
          message: 'Falha ao obter o carrinho.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    }
  }

  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  bool isRecording = false;

  void handleSend(String userId) {
    final message = controller.text.trim();
    sendMessageForChat(userId: userId, message: message);
    debugPrint('Sending message: $message');
    if (message.isNotEmpty) {
      controller.clear();
    }
  }

  final ImagePicker _picker = ImagePicker();

  var selectedImages = <File>[].obs;
  final int maxImages = 5;
  var isSending = false.obs;

  // --- Image Picking ---
  Future<void> pickChatImages() async {
    int remainingSlots = maxImages - selectedImages.length;
    if (remainingSlots <= 0) {
      CustomLoading.showNotification(
        message: "Limite de $maxImages imagens",
        messageType: MessageType.info,
      );
      return;
    }

    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      imageQuality: 70,
    );
    if (pickedFiles.isNotEmpty) {
      selectedImages.addAll(pickedFiles.map((x) => File(x.path)));
      // Optional: Automatically send after picking, or wait for user to hit send
    }
  }

  // --- Sending Logic ---
  Future<void> sendChatMessage(String chatId, {String? message}) async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    if (message == null && selectedImages.isEmpty) return;
    final chatController = Get.find<ChatController>();

    try {
      isSending.value = true;

      // Prepare data - match your backend requirements
      final Map<String, String> data = {
        'receiver_id': chatId,
        if (message != null && message.isNotEmpty) 'message': message,
      };
      print(data);

      final response = await _apiManager.uploadMultipleFilesWithData(
        endpoint: "${ApiUrl.getAllChat}/send", // Adjust to your send endpoint
        files: selectedImages.toList(),
        data: data,
        fileField: 'file_path', // Or 'images[]' based on your API
        bearerToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        selectedImages.clear();
        controller.clear();
        chatController.getAllChatOneOnOne(
          chatId,
          showLoading: false,
        ); // Refresh chat
      } else {
        CustomLoading.showNotification(
          message: 'Erro ao enviar',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      debugPrint("Send Error: $e");
    } finally {
      isSending.value = false;
    }
  }

  Future<void> sendMessageForChat({
    required String userId,
    required String message,
  }) async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {
      Map<String, dynamic> body = {"receiver_id": userId, "message": message};
      var response = await _apiManager.post(ApiUrl.sendChat, body, true);
      jsonDecode(response.body);
      await getAllChat();

      if (response.statusCode != 201) {
        CustomLoading.showNotification(
          message: 'Falha ao enviar a mensagem.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Erro de rede: $e',
        messageType: MessageType.error,
      );
    }
  }
}

class ChatController extends GetxController {
  final ApiManager _apiManager = ApiManager();
  var chatModel = ChatDataReal().obs;
  var isLoading = false.obs;
  Timer? _timer;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // Start polling if you don't have WebSockets/Firebase
  //   // _startPolling();
  // }

  @override
  void onClose() {
    _timer?.cancel(); // Critical to prevent memory leaks
    super.onClose();
  }

  void startPolling(String id) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getAllChatOneOnOne(id, showLoading: false);
    });
  }

  Future<void> getAllChatOneOnOne(String id, {bool showLoading = true}) async {
    if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    if (showLoading) isLoading.value = true;
    try {
      var response = await _apiManager.read(
        "${ApiUrl.getAllChat}/$id/messages",
        true,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var fetchedData = ChatDataReal.fromJson(data);

        // Sort: Oldest at top, Newest at bottom for standard chat feel
        fetchedData.data?.sort(
          (a, b) => (a.createdAt ?? DateTime.now()).compareTo(
            b.createdAt ?? DateTime.now(),
          ),
        );

        chatModel.value = fetchedData;
      }
    } catch (e) {
      debugPrint("Chat Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 👈 New: Observable list to store selected image files
  final RxList<File> selectedImages = <File>[].obs;
  final int maxImages = 5; // Set a limit for the number of images

  // 👈 New: Image Picker instance
  final ImagePicker _picker = ImagePicker();

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
        message: "Você pode enviar no máximo $maxImages imagens.",
        messageType: MessageType.info,
      );
    }
  }
}
