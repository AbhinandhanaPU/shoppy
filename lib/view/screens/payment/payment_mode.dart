import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/controller/address_controller.dart';
import 'package:shoppy/controller/cart_controller.dart';
import 'package:shoppy/controller/payment_controller.dart';
import 'package:shoppy/controller/receipt_controller/pdf_controller.dart';
import 'package:shoppy/model/cart_model.dart';
import 'package:shoppy/view/screens/payment/address_screen.dart';
import 'package:shoppy/view/screens/payment/cash_on_delivery.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

class PaymentMode extends StatelessWidget {
  final List<CartItem> cartItem;
  PaymentMode({
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
  Widget _buildPaymentOption({required String title, required String value}) {
    return InkWell(
      onTap: () {
        paymentController.updatePaymentMethod(value);
      },
      child: Obx(() => Container(
            // Only wrap reactive parts inside Obx
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
                Text(title, style: const TextStyle(fontSize: 18)),
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
          )),
    );
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
          Obx(
            () => Text(
              paymentController.totalPrice.value.toStringAsFixed(2),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          const Spacer(),
          CustomFilledButton(
            text: 'Place Order',
            onPressed: () async {
              if (addressController.fullAddress.value.isEmpty) {
                Get.snackbar(
                  'Select your delivery address',
                  'You have to select the address for delivery',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              if (paymentController.totalPrice.value == 0) {
                Get.snackbar("Error", "No products in the cart!",
                    snackPosition: SnackPosition.BOTTOM);
                return;
              }

              if (paymentController.selectedPaymentMethod.value ==
                  "Online Payment") {
                paymentController.openPaymentGateway(
                  contact: addressController.contactNumberController.text,
                  email: addressController.emailController.text,
                );
                if (cartItem.isNotEmpty) {
                  for (var item in cartItem) {
                    await cartController.removeFromCart(item.cartItemId);
                  }
                }
              } else {
                await placeCashOnDelivery();

                await ReceiptGenerator().generateReceipt(
                  paymentController.productList.map((product) {
                    return CartItem(
                      cartItemId: '',
                      product: product,
                      quantity: 1,
                      createdAt: Timestamp.now(),
                    );
                  }).toList(),
                );

                paymentController.productList.clear();
                if (cartItem.isNotEmpty) {
                  for (var item in cartItem) {
                    await cartController.removeFromCart(item.cartItemId);
                  }
                }
              }
            },
          )
        ],
      ),
    );
  }
}
