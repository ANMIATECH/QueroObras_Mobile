import 'package:queroobras_mobile/mvvm/const/export.dart';

class ProductDetailsController extends GetxController {
  RxInt quantity = 1.obs;

  final ApiManager _apiManager = ApiManager();

  void incrementQuantity() {
    if (quantity.value < 20) {
      quantity.value++;
    }
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

  Future getAllProduct() async {
    try {
      var response = await _apiManager.read(ApiUrl.getProduct, true);

      dynamic message = jsonDecode(response.body);
      print(message);

      if (response.statusCode == 200) {
        // Login successful
      } else {}
    } catch (e) {
      CustomLoading.showNotification(
        message: "$e",
        messageType: MessageType.error,
      );
    }
  }
}
