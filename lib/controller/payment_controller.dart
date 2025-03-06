import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoppy/controller/receipt_controller/pdf_controller.dart';
import 'package:shoppy/model/cart_model.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/view/screens/product/product_list.dart';

class PaymentController extends GetxController {
  Rx<double> totalPrice = Rx<double>(0.0);
  Rx<int> totalQuantity = Rx<int>(0);

  RxString selectedPaymentMethod = 'Cash on Delivery'.obs;
  RxList<Product> productList = <Product>[].obs;

  late Razorpay _razorpay;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();

    // Listen to payment events
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      _handlePaymentSuccess(response);
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      _handlePaymentError(response);
    });

    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      _handleExternalWallet(response);
    });
  }

  void openPaymentGateway({required String contact, required String email}) {
    var options = {
      'key': 'rzp_test_jmfiBKH3a8vLP5', // Change it to live key_id in live mode
      'amount': totalPrice.value * 100,
      'currency': 'INR',
      'name': 'ShoppY',
      'description': 'Payment for Order',
      'prefill': {'contact': contact, 'email': email},
      'theme': {
        'color': '#2196F3',
        'backdrop_color': '#000000', // Dark background
        'hide_topbar': false,
      },
      'method': {
        'upi': true, // Test mode does not support UPI
        'card': true, // Enable Card Payments
        'netbanking': true, // Enable Net Banking
        'wallet': true, // Enable Wallets (Paytm, Mobikwik, etc.)
      },
      'upi': {
        'flow':
            'collect', // Change 'flow': 'collect' → 'flow': 'intent' in live mode
      },
      'external': {
        'wallets': ['paytm', 'phonepe', 'gpay']
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log(e.toString());
      Get.snackbar("Payment Failed:", "$e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log("Payment success handler triggered");
    Get.snackbar("Success", "Payment Successful: ${response.paymentId}",
        snackPosition: SnackPosition.BOTTOM);

    await ReceiptGenerator()
        .generateReceipt(
      productList.map((product) {
        return CartItem(
          cartItemId: '',
          product: product,
          quantity: 1,
          createdAt: Timestamp.now(),
        );
      }).toList(),
    )
        .then((_) {
      productList.clear();
      Get.offAll(() => const ProductList());
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      "Error",
      "Payment Failed: ${response.code} - ${response.message ?? 'Unknown error'}",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      "Info",
      "External Wallet Selected: ${response.walletName}",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void updatePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void addProduct(Product product) {
    productList.add(product);
    _updateTotal();
  }

  void removeProduct(Product product) {
    productList.remove(product);
    _updateTotal();
  }

  void _updateTotal() {
    double price = 0.0;
    for (var product in productList) {
      price += product.price; 
    }
    totalPrice.value = price;
  }

  @override
  void onClose() {
    productList.close();
    _razorpay.clear();
    super.onClose();
  }
}
