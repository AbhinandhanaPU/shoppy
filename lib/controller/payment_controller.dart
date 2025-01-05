import 'package:get/get.dart';
import 'package:shoppy/model/product_model.dart';

class PaymentController extends GetxController {
  Rx<double> totalPrice = Rx<double>(0.0);
  Rx<int> totalQuantity = Rx<int>(0);

  RxString selectedPaymentMethod = 'Cash on Delivery'.obs;

  RxMap<Product, int> productList = <Product, int>{}.obs;

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
    super.onClose();
  }
}
