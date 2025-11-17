import 'package:get/get.dart';
import 'package:flutter/material.dart';

class VendorFormController extends GetxController {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void publishItem() {
    // Example: validation or API call
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the article name');
      return;
    }

    Get.snackbar('Success', 'Item published successfully');
  }
}
