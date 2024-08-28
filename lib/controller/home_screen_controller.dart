import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  List categoriesList = ["All"];
  int selectedCategoryIndex = 0;
  getAllProducts() {}

  // funciton to fetch categories from server
  getCategoris() async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/categories");
      final res = await http.get(url);
      if (res.statusCode == 200) {
        categoriesList.addAll(jsonDecode(res.body));
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  getProductByCategory() {}

  onCategorySelection(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }
}
