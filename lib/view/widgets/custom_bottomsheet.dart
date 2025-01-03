import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemoveProductBottomSheet extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final VoidCallback onRemove;

  const RemoveProductBottomSheet({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              'REMOVE PRODUCT FROM CART',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: Container(
              height: 100,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.asset(
                productImage,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              productName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Text(
              '₹$productPrice',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ),
          const Spacer(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: const BeveledRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 0.5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onRemove,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: const BeveledRectangleBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Remove',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
