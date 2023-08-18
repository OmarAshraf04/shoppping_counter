import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_2/data/models/data_user_model.dart';
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
  static bool isLoadingProfile = true;
  static DataUserModel? userData;

  static Future<DataUserModel?> receiveFromFireStore() async{
    try {
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DataUserModel user;
      DocumentSnapshot userA = await FirebaseFirestore.instance.
      collection('Users').doc(uid).get();
      user = DataUserModel(
          name: userA['name'],
          email: userA['email'],
          password: userA['password'],
          uid: userA['uid']
      );
      return user;
    } catch (e)
    {
      return null;
    }
  }

}