import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/screens/login/otp_screen.dart';
import 'package:shoppy/view/screens/login/scratch_card.dart';
import 'package:shoppy/view/screens/login/user_login.dart';
import 'package:shoppy/view/screens/product/product_list.dart';
import 'package:shoppy/view/screens/splash/splash_screen.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _server = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;

  final countryController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  RxString verificationId = ''.obs;

  @override
  void onInit() {
    countryController.text = '+91';
    super.onInit();
  }

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitalScreen);

    super.onReady();
  }

  // settting inital screen onLoad
  _setInitalScreen(User? user) {
    user == null
        ? Get.offAll(() => const UserLogin())
        : Get.offAll(() => const ProductList());
  }

  // otp authentcation
  Future<void> otpAuthentcation() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "${countryController.text}${phoneController.text.trim()}",
        verificationCompleted: (phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
        },
        codeSent: (verificationId, forceResendingToken) {
          this.verificationId.value = verificationId;
          Get.to(() => const OTPScreen());
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (error) {
          if (error.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The Phone number you provided is not valid');
          } else {
            Get.snackbar('Error', 'Something went wrong, Try again!');
            log(error.toString());
          }
        },
      );
    } catch (e) {
      log('Verification failed');
    }
  }

  Future<void> verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otpController.text,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User user = userCredential.user!;
      otpController.clear();
      phoneController.clear();
      DocumentSnapshot userDoc =
          await _server.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        Get.snackbar(
          'Welcome Back',
          'Successfully logged in',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
        Get.offAll(() => const ProductList());
      } else {
        await _storeUserDetails(user);
        Get.snackbar(
          'Welcome',
          'Account created successfully',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
        Get.offAll(() => const ScratchCardScreen());
      }
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP: $e');
      Get.back();
    }
  }

  // Store user details in Firestore
  Future<void> _storeUserDetails(User user) async {
    try {
      await _server.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'phoneNumber': user.phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      log("Error storing user details: $e");
      Get.snackbar('Error', 'Failed to store user details');
    }
  }

  // logout func
  Future<void> logout() async {
    await _auth.signOut().then((_) {
      Get.offAll(() => const SplashScreen());
    });
  }
}
