import 'package:get/get.dart';

class PaymentController extends GetxController {
  Rx<double> totalPrice = Rx<double>(0.0);
  Rx<int> totalQuantity = Rx<int>(0);

  RxString selectedPaymentMethod = 'Cash on Delivery'.obs;

  void updatePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }
}
