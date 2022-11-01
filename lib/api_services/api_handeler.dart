// ignore_for_file: unused_import, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shoping_app_api/models/products_model.dart';
import 'api.dart';

class ApiHandeler {
  static Future<List<ProductsModel>> getAllProducts() async {
    final uri = Uri.parse(Api.BASE_URL + Api.ALL_PRODUCTS);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    List productsList = [];
    for (var map in json) {
      productsList.add(map);
    }
    return ProductsModel.productsFromSnapsort(productsList);
  }
}
