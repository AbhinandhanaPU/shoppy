import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/screens/cart/cart_list.dart';
import 'package:shoppy/view/screens/product/product_details.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoppy'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CartList());
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
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 300),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => const ProductDetails());
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/shoes.jpeg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shoes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(
                              '₹ 1258',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        tooltip: 'Add to Cart',
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.blue,
                        ),
                      )
                    ],
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
