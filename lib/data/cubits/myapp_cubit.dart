import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_2/data/cubits/myapp_state.dart';
import 'package:shopping_2/data/models/products.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MyAppCubit extends Cubit<MyAppState> {
  MyAppCubit() : super(MyAppInitial());

  //For Products Page

  List<Products> products = [];

  Future<void> receive() async {
    try {
      emit(LoadingGridState());
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        for (var item in jsonResponse['products']) {
          products.add(Products.fromJson(item));
        }
        emit(DoneGridState());
      }
    } catch (e) {
      emit(ErrorGridState());
    }
  }

  //For Counter Page

  double sum = 0;

  void calSum(double number1, double number2) {
    sum = number1 + number2;
    emit(CalculatedSum());
  }

  //For Login Page

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoadingLoginState());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                if (value.user != null) {emit(DoneLoginState())}
              });
    } catch (e) {
      emit(ErrorLoginState(e.toString()));
    }
  }

  //For Creating Account Page
  Future<void> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(LoadingCreateState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          saveData(
            email: email,
            name: name,
            password: password,
            uid: value.user!.uid,
          ).then((value) {
            emit(DoneCreateState());
          });
        }
      });
    } catch (e) {
      emit(ErrorCreateState(e.toString()));
    }
  }

  Future<bool> saveData({
    required String email,
    required String name,
    required String password,
    required String uid,
  }) async {
    try {
      FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'email': email,
        'name': name,
        'password': password,
        'uid': uid,
        'image': ' '
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }
}
