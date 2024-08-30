import 'package:flutter/material.dart';
import 'package:folder_structure_sample_april/model/cart_screen_model/cart_model.dart';
import 'package:hive/hive.dart';

class CartScreenController with ChangeNotifier {
  final cartBox = Hive.box<CartModel>("cartBox");
  List keys = [];

  addToCart(
      {required String title,
      required num price,
      String? des,
      String? image,
      int qty = 1}) {
    cartBox.add(
      CartModel(
        price: price,
        title: title,
        des: des,
        image: image,
        qty: qty,
      ),
    );
  }

  remove() {}

  incrementQty() {}

  decQty() {}

  getAllCartItems() {
    keys = cartBox.keys.toList();
    notifyListeners();
  }

  calculateTotalAmount() {}
}
