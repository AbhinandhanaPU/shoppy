import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scratcher/scratcher.dart';
import 'package:shoppy/controller/scratch_card_controller.dart';
import 'package:shoppy/view/screens/product/product_list.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';
import 'package:shoppy/view/widgets/snackbar.dart';

class ScratchCardScreen extends StatelessWidget {
  const ScratchCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScratchCardController controller = Get.put(ScratchCardController());

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Scratcher(
              brushSize: 50,
              threshold: 75,
              color: Colors.red,
              image: Image.asset(
                "assets/images/scratch.jpg",
                fit: BoxFit.fill,
              ),
              onChange: (value) {},
              onThreshold: () => controller.playConfetti(),
              child: Container(
                height: 300,
                width: 300,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/trophy.jpg",
                      fit: BoxFit.contain,
                      width: 150,
                      height: 150,
                    ),
                    ConfettiWidget(
                      blastDirectionality: BlastDirectionality.explosive,
                      confettiController: controller.confettiController,
                      particleDrag: 0.05,
                      emissionFrequency: 0.05,
                      numberOfParticles: 30,
                      gravity: 0.05,
                      shouldLoop: false,
                      colors: const [
                        Colors.green,
                        Colors.red,
                        Colors.yellow,
                        Colors.blue,
                      ],
                    ),
                    const Text(
                      "You won",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "${controller.randomProduct.value} For ₹0",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Text(
                      'Free product for new users',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomFilledButton(
              text: 'Add to cart',
              onPressed: () {
                showToast(msg: 'Product added to cart');
                Get.to(() => const ProductList());
              },
            )
          ],
        ),
      ),
    );
  }
}
