import 'package:flutter/cupertino.dart';
import 'package:flutterd/models/Order.dart';
import 'package:flutterd/models/cart.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import '../widgets/network.dart';
import 'dart:convert';

class CartState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');

  var net = Network.network;

  CartModel? _cartmodel;
  List<OrderModel>? _orderModel;

  Future<void> getCartData() async {
    var token = storage.getItem('token');

    String url = "http://${net}/api/cart/";

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Authorization": "token  $token"
      });
      var data = json.decode(response.body) as Map; //Json convert to map
      // print(data);
      // print(data['error']);

      List<CartModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          // print(data);
          CartModel cartModel = CartModel.fromJson(element);
          // print(cartModel);
          demo.add(cartModel);
        });
        // print(demo);
        _cartmodel = demo[0];
        // print(_cartmodel);
        notifyListeners();
      }
    } catch (e) {
      print("e getcart");
      print(e);
    }
  }

  CartModel? get cartModel {
    if (_cartmodel != null) {
      return _cartmodel;
    } else {
      return null;
    }
  }

  Future<void> getOrderData() async {
    var token = storage.getItem('token');

    String url = "http://${net}/api/order/";

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Authorization": "token  $token"
      });
      var data = json.decode(response.body) as Map; //Json convert to map
      // print(data);
      // print(data['error']);

      List<OrderModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          // print(data);
          OrderModel order = OrderModel.fromJson(element);
          // print(orderModel);
          demo.add(order);
        });
        // print(demo);
        _orderModel = demo;
        // print("_orderModel $_orderModel");
        notifyListeners();
      } else {
        // print(data['data']);
      }
    } catch (e) {
      print("e getOrderData");
      print(e);
    }
  }

  Future<void> addToCart(id) async {
    var token = storage.getItem('token');
    print(id);
    String url = "http://${net}/api/addtocart/";

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({'id': id}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token  $token"
          });
      var data = json.decode(response.body) as Map; //Json convert to map
      // print(data['error']);
      // notifyListeners();
      if (data['error'] == false && data != null) {
        getCartData();
      }
    } catch (e) {
      print("e addToCart");
      print(e);
    }
  }

  Future<void> deleteSingleCart(id) async {
    var token = storage.getItem('token');

    String url = "http://${net}/api/deletesingle/";

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({'id': id}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token  $token"
          });
      var data = json.decode(response.body) as Map; //Json convert to map
      print(data['error']);
      if (data['error'] == false && data != null) {
        getCartData();
      }
    } catch (e) {
      print("e deleteSingleCart");
      print(e);
    }
  }

  Future<bool> deletecart(id) async {
    var token = storage.getItem('token');

    String url = "http://${net}/api/deletecart/";

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({'id': id}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token  $token"
          });
      var data = json.decode(response.body) as Map; //Json convert to map
      print(data['error']);
      print(data);
      if (data['error'] == false && data != null) {
        getCartData();
        _cartmodel = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("e deletecart");
      getCartData();
      print(e);
      return false;
    }
  }

  Future<bool> orderCart(
      cartid, String address, String email, String phone) async {
    var token = storage.getItem('token');

    String url = "http://${net}/api/ordernow/";

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({
            "cartid": cartid,
            "address": address,
            "email": email,
            "phone": phone
          }),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token  $token"
          });
      var data = json.decode(response.body) as Map; //Json convert to map
      print(data['error']);
      print(data);
      if (data['error'] == false && data != null) {
        getCartData();
        _cartmodel = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("e deletecart");
      getCartData();
      print(e);
      return false;
    }
  }

  List<OrderModel>? get oldOrder {
    if (_orderModel != null) {
      return [..._orderModel!];
    } else {
      return null;
    }
  }
}
