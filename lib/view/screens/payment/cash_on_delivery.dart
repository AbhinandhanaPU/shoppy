import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/screens/product/product_list.dart';

Future<void> placeCashOnDelivery() async {
  await Future.delayed(const Duration(seconds: 2));

  Get.snackbar(
    'Successful',
    'Your order has been placed successfully!',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    icon: const Icon(Icons.check_circle, color: Colors.white),
    duration: const Duration(seconds: 3),
  );

  await Future.delayed(const Duration(seconds: 2));
  Get.offAll(() => const ProductList());
}
