import 'package:flutter/material.dart';
import 'package:folder_structure_sample_april/model/cart_screen_model/cart_model.dart';
import 'package:folder_structure_sample_april/model/product_details_models/product_details_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ProductDetailsScreenController with ChangeNotifier {
  ProductDetailsModel? productctModel;
  bool isLoading = false;

  Future<void> getProductDetails({required String productId}) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/$productId");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      productctModel = productDetailsModelFromJson(res.body);
    }
    isLoading = false;
    notifyListeners();
  }

  addtoCart() {}
}
