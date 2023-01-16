import 'package:flutter/material.dart';
import 'package:flutterd/screens/cart_screen.dart';
import 'package:flutterd/screens/favourite_screen.dart';
import 'package:flutterd/screens/home_screen.dart';
import 'package:flutterd/screens/login_screen.dart';
import 'package:flutterd/screens/order_history_screen.dart';
import 'package:flutterd/screens/order_screen.dart';
import 'package:flutterd/screens/product_detail_screen.dart';
import 'package:flutterd/screens/register_screen.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = new LocalStorage('usertoken');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductState()),
        ChangeNotifierProvider(create: (ctx) => UserState()),
        ChangeNotifierProvider(create: (ctx) => CartState()),
      ],
      child: MaterialApp(
        // home: HomeScreen(),
        title: 'ToMany',
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (storage.getItem('token') == null) {
              return LoginScreen();
            }
            return HomeScreen();
          },
        ),
        // initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          FavouriteScreen.routeName: (context) => FavouriteScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
          OrderNow.routeName: (context) => OrderNow(),
        },
      ),
    );
  }
}
