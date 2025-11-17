import 'package:queroobras_mobile/mvvm/const/export.dart';


class ProductDetailsController extends GetxController {
  RxInt quantity = 1.obs;

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
}