import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterd/models/product.dart';
import 'package:flutterd/screens/cart_screen.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/network.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail-screen';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var net = Network.network;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    // print(id);
    final cart = Provider.of<CartState>(context).cartModel;

    final product = Provider.of<ProductState>(context).SingleProduct(id);
    //it provides in ProductState functions SingleProduct id,means there is call SingleProduct()
    // print(product);
    // print(product.sellingPrice);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            "Product Detail",
          ),
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
                "${cart?.cartproducts?.length ?? ''}",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Card(
              child: Container(
                // color: Colors.red,

                padding: EdgeInsets.only(top: 20, bottom: 20),
                margin: EdgeInsets.only(left: 20, right: 20),

                height: 250,

                child: Image.network(
                  "http://${net}${product.image}",
                  fit: BoxFit.contain,
                  height: 200,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Selling Price :  \$" +
                                '${product.sellingPrice.toString()}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Market Price : \$" +
                                '${product.marketPrice.toString()}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Provider.of<CartState>(context, listen: false)
                            .addToCart(id);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      label: Text("Add To Cart"),
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        '${product.title}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),
                    Text(
                      '${product.description}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            // Card(
            //   child: Text("data"),
            // )
          ],
        ),
      ),
    );
  }
}
