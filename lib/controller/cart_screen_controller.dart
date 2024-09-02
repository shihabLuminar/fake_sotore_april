import 'package:flutter/material.dart';
import 'package:folder_structure_sample_april/model/cart_screen_model/cart_model.dart';
import 'package:hive/hive.dart';

class CartScreenController with ChangeNotifier {
  final cartBox = Hive.box<CartModel>("cartBox");
  List keys = [];

  Future<void> addToCart(
      {required String title,
      required num price,
      String? des,
      num? id,
      String? image,
      int qty = 1}) async {
    bool alreadyInCart = false;

//to  check whether the item is already carted or not
    for (int i = 0; i < keys.length; i++) {
      var itemInHive = cartBox.get(keys[i]);
      if (itemInHive?.id == id) {
        alreadyInCart = true;
      }
    }

    if (alreadyInCart == false) {
      await cartBox.add(
        CartModel(
          price: price,
          title: title,
          des: des,
          image: image,
          qty: qty,
          id: id,
        ),
      );
      keys = cartBox.keys.toList();
    } else {
      print("already in cart");
    }
  }

  removeItem(var key) async {
    await cartBox.delete(key);
    keys = cartBox.keys.toList();
    notifyListeners();
  }

  incrementQty(var key) {
    final currentItemData = cartBox.get(key);
    cartBox.put(
        key,
        CartModel(
          price: currentItemData!.price,
          title: currentItemData.title,
          des: currentItemData.des,
          id: currentItemData.id,
          image: currentItemData.image,
          qty: ++currentItemData.qty,
        ));
    notifyListeners();
  }

  decQty(var key) {
    final currentItemData = cartBox.get(key);
    if (currentItemData!.qty >= 2) {
      cartBox.put(
          key,
          CartModel(
            price: currentItemData.price,
            title: currentItemData.title,
            des: currentItemData.des,
            id: currentItemData.id,
            image: currentItemData.image,
            qty: --currentItemData.qty,
          ));
      notifyListeners();
    }
  }

  getAllCartItems() {
    keys = cartBox.keys.toList();
    notifyListeners();
  }

  CartModel? getCurrentItem(var key) {
    final cureentItem = cartBox.get(key);
    return cureentItem;
  }

  calculateTotalAmount() {}
}
