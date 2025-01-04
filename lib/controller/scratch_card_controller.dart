import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:shoppy/model/product_model.dart';

class ScratchCardController extends GetxController {
  late ConfettiController confettiController;
  var randomProduct = ''.obs;

  @override
  void onInit() {
    super.onInit();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _generateRandomProduct();
  }

  void _generateRandomProduct() {
    final randomIndex = Random().nextInt(productsList.length);
    randomProduct.value = productsList[randomIndex].name;
  }

  void playConfetti() {
    confettiController.play();
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
}
