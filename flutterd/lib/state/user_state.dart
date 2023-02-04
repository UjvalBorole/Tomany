import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterd/widgets/network.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../models/user.dart';

class UserState with ChangeNotifier {
  List<User>? _profile;
  var net = Network.network;
  LocalStorage storage = new LocalStorage('usertoken');

  Future<bool> loginNow(String uname, String passw) async {
    String url = "http://${net}/api/login/";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"username": uname, "password": passw}));
      // print(response.body);
      var data = json.decode(response.body) as Map;
      // print(data['token']);
      if (data.containsKey("token")) {
        storage.setItem("token", data['token']);
        print(storage.getItem('token'));
        return true;
      }
      return false;
    } catch (e) {
      print("e loginNow");
      print(e);
      return false;
    }
  }

  Future<bool> registernow(String uname, String email, String passw) async {
    String url = "http://${net}/api/register/";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json
              .encode({"username": uname, "email": email, "password": passw}));
      // print(response.body);
      var data = json.decode(response.body) as Map;
      print(data);
      // print(data['token']);
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("e loginNow");
      print(e);
      return false;
    }
  }

  Future<void> ProfileUser() async {
    var token = storage.getItem('token');

    String url = "http://${net}/api/user/";

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Authorization": "token  $token"
      });
      // print(response.body);
      var data = json.decode(response.body) as Map; //Json convert to map
      // print(data);
      // print(data['error']);

      List<User> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          // print(data);
          User order = User.fromJson(element);
          // print(orderModel);
          demo.add(order);
        });
        // print(demo);
        _profile = demo;
        // print(_profile);
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

  List<User>? get userdata {
    if (_profile != null) {
      print(_profile);
      return [..._profile!];
    } else {
      return null;
    }
  }
}
