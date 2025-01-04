import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/controller/cart_controller.dart';
import 'package:shoppy/controller/payment_controller.dart';
import 'package:shoppy/model/cart_model.dart';
import 'package:shoppy/view/screens/payment/address_screen.dart';
import 'package:shoppy/view/widgets/cart_empty_widget.dart';
import 'package:shoppy/view/widgets/custom_bottomsheet.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final PaymentController paymentController = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(),
      body: StreamBuilder<List<CartItem>>(
        stream: cartController.getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyCartWidget();
          }

          final cartItems = snapshot.data!;

          paymentController.totalPrice.value = cartItems.fold(
            0.0,
            (sum, item) => sum + (item.product.price * item.quantity),
          );
          paymentController.totalQuantity.value = cartItems.fold<int>(
            0,
            (sum, item) => sum + item.quantity,
          );

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cartItems.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 5),
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];

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
                                      cartItem.product.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    cartItem.product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        '₹${cartItem.product.price * cartItem.quantity}',
                                        style: const TextStyle(
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
                                            shape:
                                                const BeveledRectangleBorder(),
                                            builder: (context) {
                                              return RemoveProductBottomSheet(
                                                productName:
                                                    cartItem.product.name,
                                                productImage:
                                                    cartItem.product.imageUrl,
                                                productPrice: cartItem
                                                    .product.price
                                                    .toString(),
                                                onRemove: () {
                                                  cartController.removeFromCart(
                                                      cartItem.cartItemId);
                                                  Get.back();
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Supplier / Sold By :',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        cartItem.product.soldBy,
                                        style: const TextStyle(fontSize: 15),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Price Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Items',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  cartItems.length.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Quantity',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  paymentController.totalQuantity.value
                                      .toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Product Price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '₹ ${paymentController.totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Order Total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '₹ ${paymentController.totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      '₹ ${paymentController.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
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
          );
        },
      ),
    );
  }
}
