import 'dart:developer';

import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoppy/model/product_model.dart';

class PaymentController extends GetxController {
  Rx<double> totalPrice = Rx<double>(0.0);
  Rx<int> totalQuantity = Rx<int>(0);

  RxString selectedPaymentMethod = 'Cash on Delivery'.obs;

  RxMap<Product, int> productList = <Product, int>{}.obs;

  late Razorpay _razorpay;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();

    // Listen to payment events
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openPaymentGateway({required String contact, required String email}) {
    var options = {
      'key': 'rzp_test_jmfiBKH3a8vLP5',
      'amount': totalPrice.value * 100,
      'currency': 'INR',
      'name': 'ShoppY',
      'description': 'Payment for Order',
      'prefill': {'contact': contact, 'email': email},
      'theme': {'color': '#2196F3'},
      'method': {
        'upi': true,
      },
    };

    try {
      _razorpay.open(options);
      Get.back();
    } catch (e) {
      log(e.toString());
      Get.snackbar("Pament Failed:", "$e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Success", "Payment Successful: ${response.paymentId}",
        snackPosition: SnackPosition.BOTTOM);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      "Error",
      "Payment Failed: ${response.message}",
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

  void addProduct(Product product, int quantity) {
    productList.clear();

    productList[product] = quantity;

    _updateTotals();
  }

  void removeProduct(Product product) {
    if (productList.containsKey(product)) {
      productList.remove(product);
      _updateTotals();
    }
  }

  void _updateTotals() {
    double price = 0.0;
    int quantity = 0;

    productList.forEach((product, qty) {
      price += product.price * qty;
      quantity += qty;
    });

    totalPrice.value = price;
    totalQuantity.value = quantity;
  }

  @override
  void onClose() {
    productList.close();
    _razorpay.clear();
    super.onClose();
  }
}
