import 'package:flutter/material.dart';
import 'package:flutterd/screens/favourite_screen.dart';
import 'package:flutterd/screens/home_screen.dart';
import 'package:flutterd/screens/login_screen.dart';
import 'package:flutterd/screens/order_screen.dart';
import 'package:localstorage/localstorage.dart';

import '../screens/order_history_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  LocalStorage storage = new LocalStorage('usertoken');

  void logoutnow() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.deepPurple,
      child: Column(
        children: [
          AppBar(
            title: Text("ToMany"),
            backgroundColor: Colors.deepPurple,
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            trailing: Icon(
              Icons.home,
              color: Colors.deepPurple,
            ),
            title: Text("Home"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FavouriteScreen.routeName);
            },
            trailing: Icon(
              Icons.favorite,
              color: Colors.deepPurple,
            ),
            title: Text("Favourites"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
            trailing: Icon(
              Icons.history,
              color: Colors.deepPurple,
            ),
            title: Text("orders"),
          ),
          Spacer(),
          ListTile(
            onTap: () {
              logoutnow();
            },
            trailing: Icon(
              Icons.logout,
              color: Colors.deepPurple,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
