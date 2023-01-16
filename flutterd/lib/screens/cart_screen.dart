import 'package:flutter/material.dart';
import 'package:flutterd/screens/home_screen.dart';
import 'package:flutterd/screens/order_screen.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/widgets/network.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  var net = Network.network;
  static const routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    if (cart == null)
      return Scaffold(
        appBar:
            AppBar(title: Text("Carts"), backgroundColor: Colors.deepPurple),
        body: Center(
          child: Text("No Cart Found"),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          title: Text("Carts"),
          backgroundColor: Colors.deepPurple,
          actions: [
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                label: Text(
                  "${cart.cartproducts?.length ?? ''}",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Total: ${cart.total.toString()}"),
                  Text("Date: ${cart.date.toString()}"),
                  ElevatedButton(
                    onPressed: cart.cartproducts!.length <= 0
                        ? null
                        : () {
                            Navigator.of(context).pushNamed(OrderNow.routeName);
                          },
                    child: Text(
                      "Order",
                      style: TextStyle(fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple),
                  ),
                  ElevatedButton(
                    onPressed: cart.cartproducts!.length <= 0
                        ? null
                        : () async {
                            bool isdelete = await Provider.of<CartState>(
                                    context,
                                    listen: false)
                                .deletecart(cart.id);
                            // if (isdelete) {
                            //   Navigator.of(context)
                            //       .pushReplacementNamed(HomeScreen.routeName);
                            // }
                          },
                    child: Text(
                      "Delete",
                      style: TextStyle(fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 175, 26, 26)),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartproducts!.length,
                  itemBuilder: (context, index) {
                    var item = cart.cartproducts![index];
                    print(item.product![0].image);
                    return Card(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Image.network(
                                      "http://${net}${item.product![0].image!}",
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  Column(children: [
                                    Text(
                                      "${item.product![0].title}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Price : ${item.price}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "quantity : ${item.quantity}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                ]),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<CartState>(context, listen: false)
                                    .deleteSingleCart(item.id);
                              },
                              child: Text("Delete"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple[900]),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}
