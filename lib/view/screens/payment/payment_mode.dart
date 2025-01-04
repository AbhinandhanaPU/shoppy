import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/controller/address_controller.dart';
import 'package:shoppy/controller/payment_controller.dart';
import 'package:shoppy/view/screens/payment/payment.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

class PayementMode extends StatelessWidget {
  const PayementMode({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController paymentController = Get.put(PaymentController());
    final AddressController addressController = Get.put(AddressController());

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Payment Mode'),
      ),
      body: Column(
        children: [
          _buildPaymentSelectionSection(paymentController),
          const SizedBox(height: 10),
          _buildAddressSection(addressController),
          const Spacer(),
          _buildOrderSection(paymentController),
        ],
      ),
    );
  }

  //  payment mode selection widget
  Widget _buildPaymentSelectionSection(PaymentController paymentController) {
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
            paymentController: paymentController,
          ),
          const SizedBox(height: 15),
          _buildPaymentOption(
            title: 'Online Payment',
            value: 'Online Payment',
            paymentController: paymentController,
          ),
        ],
      ),
    );
  }

  // Payment Option widget
  Widget _buildPaymentOption({
    required String title,
    required String value,
    required PaymentController paymentController,
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

  //  address displaying widget
  Widget _buildAddressSection(AddressController addressController) {
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
            onPressed: () => Get.back(),
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
  Widget _buildOrderSection(PaymentController paymentController) {
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
              await simulatePayment();
            },
          )
        ],
      ),
    );
  }
}
