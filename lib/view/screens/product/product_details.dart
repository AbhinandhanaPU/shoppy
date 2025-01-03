import 'package:flutter/material.dart';
import 'package:shoppy/view/widgets/snackbar.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

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
                'assets/images/shoes.jpeg',
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'product.name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'product.description',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'asd',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showToast(msg: '${'product.name'} added to cart!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: const BeveledRectangleBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showToast(msg: 'Buying ${'product.name'}...');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: const BeveledRectangleBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 10)),
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
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
