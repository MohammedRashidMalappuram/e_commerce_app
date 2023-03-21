import 'dart:convert';
import 'package:e_commerce_app/model/api_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum Providertatus { loading, completed }

class ProviderFile extends ChangeNotifier {
  late Welcome data;
  late SharedPreferences _pref1;
  late SharedPreferences _prefs2;

  Providertatus status = Providertatus.loading;

  fetchApi() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      data = Welcome.fromJson(jsonDecode(response.body));
      status = Providertatus.completed;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    notifyListeners();
  }

  List<int> cartSample = [];

  Future<void> saveSF() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String> stringNumber1 = cartSample
        .map(
          (cartSample) => cartSample.toString(),
        )
        .toList();
    await prefs1.setStringList("number1", stringNumber1);
  }

  loadSF() async {
    _pref1 = await SharedPreferences.getInstance();
    List<String>? stringNumber1 = _pref1.getStringList("number1");
    if (stringNumber1 != null) {
      List<int> number1 =
          stringNumber1.map((stringNumber) => int.parse(stringNumber)).toList();
      cartSample = number1;
    }
  }

  void removeItem(int index1) async {
    cartSample.removeAt(index1);
    await saveSF();
    notifyListeners();
  }




  List<int> favorite = [];

  Future<void> saveS() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    List<String> stringNumber2 = favorite
        .map(
          (favorite) => favorite.toString(),
        )
        .toList();
    await prefs2.setStringList("number2", stringNumber2);
  }

  loadS() async {
    _prefs2 = await SharedPreferences.getInstance();
    List<String>? stringNumber2 = _prefs2.getStringList("number2");
    if (stringNumber2 != null) {
      List<int> number2 =
          stringNumber2.map((stringNumber) => int.parse(stringNumber)).toList();
      favorite = number2;
    }
  }

  void removeFavorite(int index2) async {
    favorite.removeAt(index2);
    await saveS();
    notifyListeners();
  }
}
