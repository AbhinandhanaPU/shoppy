import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/controller/auth_controller.dart';
import 'package:shoppy/controller/cart_controller.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/view/screens/cart/cart_list.dart';
import 'package:shoppy/view/screens/product/product_details.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            authController.logout();
          },
          icon: const Icon(Icons.logout),
        ),
        title: const Text('Shoppy'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CartScreen());
            },
            tooltip: 'Cart',
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.blue,
              size: 30,
            ),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: productsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 300,
        ),
        itemBuilder: (context, index) {
          final product = productsList[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => ProductDetails(product: product));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '₹${product.price.round()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
