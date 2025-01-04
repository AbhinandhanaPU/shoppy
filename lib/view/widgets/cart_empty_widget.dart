import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset('assets/images/emptycart.png'),
            const SizedBox(height: 10),
            const Text(
              'Your Cart is Empty',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Looks like you have not added anything to you cart. Go ahead & explore top categories.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
