import 'package:flutter/material.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

class PayementMode extends StatefulWidget {
  const PayementMode({super.key});

  @override
  State<PayementMode> createState() => _PayementModeState();
}

class _PayementModeState extends State<PayementMode> {
  String selectedPaymentMethod = 'Cash on Delivery';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Payment Mode'),
      ),
      body: Column(
        children: [
          Container(
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
                  amount: '₹1258',
                  value: 'Cash on Delivery',
                ),
                const SizedBox(height: 15),
                _buildPaymentOption(
                  title: 'Online Payment',
                  amount: '₹1258',
                  value: 'Online Payment',
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Row(
              children: [
                Text(
                  '₹1258',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Spacer(),
                CustomFilledButton(text: 'Place Order')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String amount,
    required String value,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPaymentMethod == value ? Colors.blue : Colors.grey,
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
                  amount,
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
              groupValue: selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue!;
                });
              },
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
