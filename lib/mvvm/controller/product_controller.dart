import 'package:queroobras_mobile/mvvm/const/export.dart';

class ProductDetailsController extends GetxController {
  RxInt quantity = 1.obs;

  final ApiManager _apiManager = ApiManager();
  @override
  void onInit() {
    super.onInit();
    getCart();
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

  Future getAllProduct({bool isInitial = false}) async {
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

      var response = await _apiManager.read(ApiUrl.getProduct, true, params);

      jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        product.value = ItemForCurrentUser.fromJson(data);

        final List<Item> fetchedItems = product.value.items ?? [];
        final int totalPages =
            product.value.pagination?.lastPage ??
            1; // Adjust keys based on your API

        if (fetchedItems.isNotEmpty) {
          // itemList.addAll(fetchedItems);
          masterItemList.addAll(fetchedItems);

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
      getAllProduct();
    }
  }

  Future<void> addToCart({required String itemSlug}) async {
    try {
      var data = {'item_slug': itemSlug, 'quantity': "${quantity.value}"};
      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.addToCart, data, true);
      isLoading.value = false;

      if (response.statusCode == 200) {
        CustomLoading.showNotification(
          message: 'Product add to cart',
          messageType: MessageType.success,
        );
      } else {
        CustomLoading.showNotification(
          message: 'Failed to add to cart.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: 'Network error: $e',
        messageType: MessageType.error,
      );
    }
  }

  Future<void> removeFromCart({required String itemSlug}) async {
    try {
      var response = await _apiManager.delete("${ApiUrl.cart}/$itemSlug", true);

      if (response.statusCode == 200) {
        await getCart();
        CustomLoading.showNotification(
          message: 'Item removed from cart.', // Adjusted message
          messageType: MessageType.success,
        );
      } else {
        CustomLoading.showNotification(
          message: 'Failed to add to cart.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: 'Network error: $e',
        messageType: MessageType.error,
      );
    }
  }

  var cart = CartModel().obs;

  Future<void> getCart() async {
    try {
      var response = await _apiManager.read(ApiUrl.cart, true);

      if (response.statusCode == 200) {
        var date = jsonDecode(response.body);

        cart.value = CartModel.fromJson(date);
      } else {
        CustomLoading.showNotification(
          message: 'Failed to get == cart.',
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: 'Network error: $e',
        messageType: MessageType.error,
      );
    }
  }
}
