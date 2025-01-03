import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/screens/payment/address_screen.dart';
import 'package:shoppy/view/widgets/custom_bottomsheet.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              isThreeLine: true,
                              leading: Container(
                                height: 100,
                                width: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Image.asset(
                                  'assets/images/shoes.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: const Text(
                                'Running Shoes',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  const Text(
                                    '₹1258',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isDismissible: false,
                                        shape: const BeveledRectangleBorder(),
                                        builder: (context) {
                                          return RemoveProductBottomSheet(
                                            productName: 'Running Shoes',
                                            productImage:
                                                'assets/images/shoes.jpeg',
                                            productPrice: '1258',
                                            onRemove: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.close,
                                          size: 18,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'remove',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 18,
                                ),
                              ),
                            ),
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Supplier / Sold By :',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    ' product.soldBy',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    color: Colors.white,
                    width: double.infinity,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price Details',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Items',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Product Price',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '+  ₹1258',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Total',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '₹1258',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  '₹ 1258',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.green,
                  ),
                ),
                const Spacer(),
                CustomFilledButton(
                  text: 'Continue',
                  onPressed: () => Get.to(() => const AddressScreen()),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
