import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/screens/payment/payment_mode.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';
import 'package:shoppy/view/widgets/textformfield.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Add Delivery Address'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormFieldWidget(
                    labelText: 'Name *',
                  ),
                  SizedBox(height: 15),
                  TextFormFieldWidget(
                    labelText: 'Contact Number *',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 15),
                  TextFormFieldWidget(
                    labelText: 'House No./ Building Name*',
                  ),
                  SizedBox(height: 15),
                  TextFormFieldWidget(
                    labelText: 'Road name / Area / Colony *',
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          labelText: 'City *',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormFieldWidget(
                          labelText: 'State *',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormFieldWidget(
                    labelText: 'Pincode *',
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: CustomFilledButton(
            text: 'Save Address and Continue',
            onPressed: () => Get.to(() => const PayementMode()),
          ),
        ),
      ],
    );
  }
}
