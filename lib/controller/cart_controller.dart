import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/model/cart_model.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  var isInCart = false.obs;

  Future<void> addToCart(Product product, int quantity) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not logged in');
        return;
      }

      final cartRef =
          _firestore.collection('users').doc(user.uid).collection('cart');

      final existingItem =
          await cartRef.where('product.name', isEqualTo: product.name).get();

      if (existingItem.docs.isNotEmpty) {
        final cartItemDoc = existingItem.docs.first;
        await cartItemDoc.reference.update({
          'quantity': cartItemDoc['quantity'] + quantity,
        });
        Get.snackbar(
          'Success',
          'Cart updated',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      } else {
        final uuid = const Uuid().v4();
        await cartRef.doc(uuid).set(CartItem(
              cartItemId: uuid,
              product: product,
              quantity: quantity,
              createdAt: Timestamp.now(),
            ).toMap());
        Get.snackbar(
          'Success',
          'Item added to cart',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      }
      checkIfInCart(product);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item to cart: $e');
    }
  }

  Future<void> checkIfInCart(Product product) async {
    bool status = await isInFirestoreCart(product);
    isInCart.value = status;
  }

  Future<bool> isInFirestoreCart(Product product) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return false;
      }
      final cartRef =
          _firestore.collection('users').doc(user.uid).collection('cart');
      final existingItem =
          await cartRef.where('product.name', isEqualTo: product.name).get();

      return existingItem.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Stream<List<CartItem>> getCartItems() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    final cartRef =
        _firestore.collection('users').doc(user.uid).collection('cart');
    return cartRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList();
    });
  }

  Future<void> removeFromCart(String cartItemId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not logged in');
        return;
      }

      final cartRef =
          _firestore.collection('users').doc(user.uid).collection('cart');
      await cartRef.doc(cartItemId).delete();
      Get.snackbar('Success', 'Item removed from cart');
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove item from cart: $e');
    }
  }
}
