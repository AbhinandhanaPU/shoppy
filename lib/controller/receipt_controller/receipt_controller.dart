import 'package:get/get.dart';

class ReceiptController extends GetxController {
  var isGeneratingReceipt = false.obs;
  var receiptPath = ''.obs;

  void setGeneratingReceipt(bool status) {
    isGeneratingReceipt.value = status;
  }

  void setReceiptPath(String path) {
    receiptPath.value = path;
  }
}
