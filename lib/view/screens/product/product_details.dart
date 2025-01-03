// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/model/product_model.dart';
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
                fontSize: 20,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: CustomBorderedButton(
                    text: 'Add to cart',
                    radius: 0,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: CustomFilledButton(
                    text: 'Buy Now',
                    radius: 0,
                    onPressed: () => Get.to(() => const AddressScreen()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
