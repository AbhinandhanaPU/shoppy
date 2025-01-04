import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/screens/payment/payment_mode.dart';

class AddressController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController roadNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  RxString fullAddress = ''.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var addressList = <String>[].obs;
  var selectedAddressIndex = (-1).obs;
  var isFormVisible = false.obs;

  @override
  void onInit() {
    fetchAddress();
    super.onInit();
  }

  Future<void> addAddressFirestore() async {
    try {
      final user = auth.currentUser;
      await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('addresses')
          .add({
        'name': nameController.text,
        'contactNumber': contactNumberController.text,
        'houseNo': houseNoController.text,
        'roadName': roadNameController.text,
        'city': cityController.text,
        'state': stateController.text,
        'pincode': pincodeController.text,
        'fullAddress': fullAddress.value,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        'Success',
        'Address saved.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      fetchAddress();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add address: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void selectAddress(int index) {
    selectedAddressIndex.value = index;
    fullAddress.value = addressList[index];
    isFormVisible.value = false;
  }

  void toggleAddressFormVisibility() {
    isFormVisible.value = !isFormVisible.value;
    if (isFormVisible.value) {
      selectedAddressIndex.value = -1;
    }
  }

  Future<void> fetchAddress() async {
    try {
      addressList.value = [];
      final user = auth.currentUser;

      final QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('addresses')
          .orderBy('timestamp', descending: true)
          .get();

      addressList.clear();
      for (var doc in querySnapshot.docs) {
        addressList.add(doc['fullAddress']);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch addresses: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteAddress(String docID) async {
    try {
      final user = auth.currentUser;

      await firestore
          .collection('users')
          .doc(user!.uid)
          .collection('addresses')
          .doc(docID)
          .delete();

      Get.snackbar(
        'Success',
        'Address deleted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong, try again!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool validateFields() {
    if (nameController.text.isEmpty ||
        contactNumberController.text.isEmpty ||
        houseNoController.text.isEmpty ||
        roadNameController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        pincodeController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void generateAddress() {
    fullAddress.value = '''
${nameController.text} 
${houseNoController.text}, ${roadNameController.text}, ${cityController.text}, ${stateController.text}, ${pincodeController.text}, 
Contact: ${contactNumberController.text}''';
  }

  void saveAddress() async {
    if (fullAddress.value.isNotEmpty || validateFields()) {
      if (validateFields()) {
        generateAddress();
        await addAddressFirestore();
      }
      try {
        clearFields();
        isFormVisible.value = false;

        Get.to(() => const PayementMode());
      } catch (e) {
        Get.snackbar('Error', 'Failed to save the address. Please try again.');
      }
    } else {
      Get.snackbar(
        'Error',
        'Please select an address or enter a valid address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void clearFields() {
    nameController.clear();
    contactNumberController.clear();
    houseNoController.clear();
    roadNameController.clear();
    cityController.clear();
    stateController.clear();
    pincodeController.clear();
  }
}
