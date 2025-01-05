// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/controller/address_controller.dart';
import 'package:shoppy/controller/cart_controller.dart';
import 'package:shoppy/controller/payment_controller.dart';
import 'package:shoppy/controller/receipt_controller/pdf_controller.dart';
import 'package:shoppy/model/cart_model.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/view/screens/payment/address_screen.dart';
import 'package:shoppy/view/screens/payment/payment.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

class PayementMode extends StatelessWidget {
  final List<CartItem> cartItem;
  PayementMode({
    super.key,
    this.cartItem = const [],
  });

  final PaymentController paymentController = Get.put(PaymentController());
  final AddressController addressController = Get.put(AddressController());
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Payment Mode'),
      ),
      body: Column(
        children: [
          _buildPaymentSelectionSection(),
          const SizedBox(height: 10),
          cartItem.isNotEmpty
              ? addressController.fullAddress.value == ''
                  ? _buildSelectAddressButton()
                  : _buildAddressSection()
              : _buildAddressSection(),
          const Spacer(),
          _buildOrderSection(context),
        ],
      ),
    );
  }

  //  payment mode selection widget
  Widget _buildPaymentSelectionSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select payment mode',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          _buildPaymentOption(
            title: 'Cash on Delivery',
            value: 'Cash on Delivery',
          ),
          const SizedBox(height: 15),
          _buildPaymentOption(
            title: 'Online Payment',
            value: 'Online Payment',
          ),
        ],
      ),
    );
  }

  // Payment Option widget
  Widget _buildPaymentOption({
    required String title,
    required String value,
  }) {
    return Obx(() {
      return InkWell(
        onTap: () {
          paymentController.updatePaymentMethod(value);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: paymentController.selectedPaymentMethod.value == value
                  ? Colors.blue
                  : Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    paymentController.totalPrice.value.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Radio<String>(
                value: value,
                groupValue: paymentController.selectedPaymentMethod.value,
                onChanged: (String? newValue) {
                  paymentController.updatePaymentMethod(newValue!);
                },
                activeColor: Colors.blue,
              ),
            ],
          ),
        ),
      );
    });
  }

  // 'Select Address' button widget
  Widget _buildSelectAddressButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.delivery_dining_rounded,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Delivery Adrees',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: CustomFilledButton(
              text: 'Select Address',
              onPressed: () {
                Get.to(() => const AddressScreen());
              },
            ),
          ),
        ],
      ),
    );
  }

  //  address displaying widget
  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              addressController.fullAddress.value,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.to(() => const AddressScreen()),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              shape: const BeveledRectangleBorder(
                side: BorderSide(
                  width: 0.2,
                  color: Colors.blue,
                ),
              ),
            ),
            child: const Text('change'),
          ),
        ],
      ),
    );
  }

  // place order
  Widget _buildOrderSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            paymentController.totalPrice.value.toStringAsFixed(2),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const Spacer(),
          CustomFilledButton(
              text: 'Place Order',
              onPressed: () async {
                if (addressController.fullAddress.value != '') {
                  log(cartItem.length.toString());
                  log(paymentController.productList.length.toString());

                  if (cartItem.isNotEmpty ||
                      paymentController.productList.isNotEmpty) {
                    bool isOnline =
                        paymentController.selectedPaymentMethod.value ==
                            'Online Payment';
                    await simulatePayment(isOnline);

                    await ReceiptGenerator()
                        .generateReceipt(cartItem.isNotEmpty
                            ? cartItem
                            : paymentController.productList.entries
                                .map((entry) {
                                return CartItem(
                                  cartItemId: '',
                                  product: entry.key,
                                  quantity: entry.value,
                                  createdAt: Timestamp.now(),
                                );
                              }).toList())
                        .then((value) async {
                      if (cartItem.isNotEmpty) {
                        for (var item in cartItem) {
                          await cartController.removeFromCart(item.cartItemId);
                        }
                      }

                      if (paymentController.productList.isNotEmpty) {
                        for (var item in productsList) {
                          paymentController.removeProduct(item);
                        }
                      }
                    });
                  } else {
                    Get.snackbar(
                      'No items in cart',
                      'You must add items to your cart or select a product before placing the order.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                } else {
                  Get.snackbar(
                    'Select your delivery address',
                    'You have to select the address for delivery',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              })
        ],
      ),
    );
  }
}
