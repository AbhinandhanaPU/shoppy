import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/controller/address_controller.dart';
import 'package:shoppy/model/cart_model.dart';
import 'package:shoppy/view/screens/payment/payment_mode.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';
import 'package:shoppy/view/widgets/textformfield.dart';

class AddressScreen extends StatelessWidget {
  final List<CartItem> cartItem;
  const AddressScreen({
    super.key,
    this.cartItem = const [],
  });

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Add Delivery Address'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addressController.addressList.length,
                itemBuilder: (context, index) {
                  final address = addressController.addressList[index];
                  return Obx(
                    () => Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              address,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Radio<int>(
                            value: index,
                            groupValue:
                                addressController.selectedAddressIndex.value,
                            onChanged: (value) {
                              addressController.selectAddress(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                addressController.toggleAddressFormVisibility();
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '+  Add Address',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: addressController.isFormVisible.value,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormFieldWidget(
                        labelText: 'Name *',
                        textEditingController: addressController.nameController,
                      ),
                      const SizedBox(height: 15),
                      TextFormFieldWidget(
                        labelText: 'Contact Number *',
                        textEditingController:
                            addressController.contactNumberController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 15),
                      TextFormFieldWidget(
                        labelText: 'Email Address *',
                        textEditingController:
                            addressController.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      TextFormFieldWidget(
                        labelText: 'House No./ Building Name*',
                        textEditingController:
                            addressController.houseNoController,
                      ),
                      const SizedBox(height: 15),
                      TextFormFieldWidget(
                        labelText: 'Road name / Area / Colony *',
                        textEditingController:
                            addressController.roadNameController,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormFieldWidget(
                              labelText: 'City *',
                              textEditingController:
                                  addressController.cityController,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormFieldWidget(
                              labelText: 'State *',
                              textEditingController:
                                  addressController.stateController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextFormFieldWidget(
                        labelText: 'Pincode *',
                        textEditingController:
                            addressController.pincodeController,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      persistentFooterButtons: [
        Obx(
          () => addressController.fullAddress.value != '' ||
                  addressController.isFormVisible.value
              ? SizedBox(
                  width: double.infinity,
                  child: CustomFilledButton(
                    text: 'Save Address and Continue',
                    onPressed: () {
                      addressController.saveAddress();
                      Get.to(() => PaymentMode(cartItem: cartItem));
                    },
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
