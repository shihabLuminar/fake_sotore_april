import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folder_structure_sample_april/model/home_screen_models/product_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  bool isCategoriesLoading =
      false; // for setting loading state while fetching  categories list
  bool isProductsLoading =
      false; // for setting loading state while fetching  products list
  List categoriesList = ["All"];
  int selectedCategoryIndex = 0;
  List<ProductModel> productsList = [];

  // to fetch all  products form server
  getAllProducts({String category = ""}) async {
    isProductsLoading = true;
    notifyListeners();
    final allUrl = Uri.parse("https://fakestoreapi.com/products");
    final categoryurl =
        Uri.parse("https://fakestoreapi.com/products/category/$category");

    final url = category.isEmpty ? allUrl : categoryurl;
    final res = await http.get(url);
    if (res.statusCode == 200) {
      productsList = productModelFromJson(res.body);
    }
    isProductsLoading = false;
    notifyListeners();
  }

  // funciton to fetch categories from server
  getCategoris() async {
    isCategoriesLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/categories");
      final res = await http.get(url);
      if (res.statusCode == 200) {
        categoriesList.addAll(jsonDecode(res.body));
      }
    } catch (e) {
      print(e);
    }
    isCategoriesLoading = false;
    notifyListeners();
  }

  getProductByCategory() {}

  onCategorySelection(int index) {
    selectedCategoryIndex = index;
    if (selectedCategoryIndex == 0) {
      getAllProducts(); //to fetch all products
    } else {
      getAllProducts(
          category: categoriesList[
              selectedCategoryIndex]); // to fetch products by category
    }
    notifyListeners();
  }
}
