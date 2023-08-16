import 'package:shopping_2/data/models/products.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DataSource {

  static Future<List<Products>> receive() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/products'));

    List<Products> pList = [];

    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var item in jsonResponse['products']) {
        pList.add(Products.fromJson(item));
      }
    }
    return pList;
  }

  static List<Products> products = [];
  static bool isLoading = true;

}