import 'package:flutter/material.dart';
import 'package:flutterd/screens/cart_screen.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/singleProduct.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-screens';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _init = true;
  bool _isLoading = false;
  String vr = '';

  @override
  void didChangeDependencies() async {
    if (_init) {
      Provider.of<CartState>(context).getCartData();
      Provider.of<CartState>(context).getOrderData();
      _isLoading = await Provider.of<ProductState>(context).getProducts();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  ProductState product = ProductState();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;

    final prod =
        Provider.of<ProductState>(context).products; //ProductState.products
    if (!_isLoading)
      return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("ToMany"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.purpleAccent,
                color: Colors.redAccent,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
                width: 305,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.purpleAccent,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      );
    else
      return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
            "ToMany",
          ),
          backgroundColor: Colors.deepPurple,
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(
                "${cart?.cartproducts?.length ?? vr}",
                // " ",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: prod.length,
          itemBuilder: (ctx, i) => SingleProduct(
            id: prod[i].id!,
            title: prod[i].title!,
            image: prod[i].image!,
            favourite: prod[i].favourite!,
          ),
        ),
      );
  }
}
