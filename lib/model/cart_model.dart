import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppy/model/product_model.dart';

class CartItem {
  final String cartItemId;
  final Product product;
  final int quantity;
  final Timestamp createdAt;

  CartItem({
    required this.cartItemId,
    required this.product,
    required this.quantity,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'cartItemId': cartItemId,
      'product': product.toMap(),
      'quantity': quantity,
      'createdAt': createdAt,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      cartItemId: map['cartItemId'],
      product: Product.fromMap(map['product']),
      quantity: map['quantity'],
      createdAt: map['createdAt'],
    );
  }
}
