import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterd/models/product.dart';
import 'package:http/http.dart ' as http;
import 'package:localstorage/localstorage.dart';

import '../widgets/network.dart';

class ProductState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');
  var net = Network.network;
  List<product> _products = [];

  Future<bool> getProducts() async {
    String url = "http://${net}/api/products/";
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Authorization": "token  $token"
      });
      var data = json.decode(response.body); //Json convert to map
      List<product> temp = [];
      data.forEach((element) {
        product pro = product.fromJson(
            element); //this data is goes in the model and set in the variables for easily access any class
        temp.add(pro);
      });

      _products = temp;
      notifyListeners();
      // getProducts();
      return true;
    } catch (e) {
      print("e getProducts");
      print(e);
      return false;
    }
  }

  Future<void> favouriteButton(int id) async {
    var token = storage.getItem('token');

    String url = "http://${net}/api/favourite/";

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({'id': id}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token  $token"
          });
      var data = json.decode(response.body); //Json convert to map
      print(data);
      // notifyListeners();
      getProducts();
    } catch (e) {
      print("e favouriteButton");
      print(e);
    }
  }

  List<product> get products {
    //products name you are retrive the data from the _products list and render the data where we call
    return [..._products];
  }

  List<product> get favourites {
    return _products.where((element) => element.favourite == true).toList();
  }

  product SingleProduct(id) {
    return _products.firstWhere((element) => element.id == id);
    //it return the _products list element.id==id of firstly match element
  }
}
