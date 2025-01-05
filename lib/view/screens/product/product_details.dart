// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/controller/cart_controller.dart';
import 'package:shoppy/controller/payment_controller.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/view/screens/cart/cart_list.dart';
import 'package:shoppy/view/screens/payment/address_screen.dart';
import 'package:shoppy/view/widgets/custom_button_border.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({
    super.key,
    required this.product,
  });
  Product product;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final PaymentController paymentController = Get.put(PaymentController());
    cartController.checkIfInCart(product);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                product.imageUrl,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '₹${product.price.round()}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sold By :',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text(
                    product.soldBy,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
            ),
            const Divider(),
            const Spacer(),
            Obx(() {
              bool isInCart = cartController.isInCart.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomBorderedButton(
                      text: isInCart ? 'Go to Cart' : 'Add to Cart',
                      radius: 0,
                      onPressed: () {
                        if (isInCart) {
                          Get.to(() => const CartScreen());
                        } else {
                          cartController.addToCart(product, 1);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: CustomFilledButton(
                      text: 'Buy Now',
                      radius: 0,
                      onPressed: () {
                        paymentController.addProduct(product, 1);
                        Get.to(() => const AddressScreen());
                      },
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
