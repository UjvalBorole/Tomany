import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterd/widgets/network.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class UserState with ChangeNotifier {
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

  Future<bool> registernow(String uname, String passw) async {
    String url = "http://${net}/api/register/";
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"username": uname, "password": passw}));
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
}
