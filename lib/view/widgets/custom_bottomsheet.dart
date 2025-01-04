import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/widgets/custom_button_border.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

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
                  child: CustomBorderedButton(
                    text: 'Cancel',
                    radius: 0,
                    bgColor: Colors.white,
                    fgColor: Colors.black,
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomFilledButton(
                    text: 'Remove',
                    radius: 0,
                    onPressed: onRemove,
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
