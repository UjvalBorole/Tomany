import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutterd/screens/home_screen.dart';
import 'package:flutterd/screens/order_screen.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/widgets/network.dart';
import 'package:provider/provider.dart';

class BottomCartSheet extends StatelessWidget {
  var net = Network.network;
  static const routeName = '/cart-screen';
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    if (cart == null)
      return Scaffold(
        body: Center(
          child: Text("No Cart Found"),
        ),
      );
    else
      return Material(
        child: Container(
          height: 600,
          padding: EdgeInsets.only(top: 20),
          color: Color(0xFFCEDDEE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 500,
                // color: Colors.red,
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: cart.cartproducts!.length,
                      itemBuilder: (context, index) {
                        var item = cart.cartproducts![index];
                        return Container(
                          // color: Colors.red,

                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 150,

                          decoration: BoxDecoration(
                              color: Color(0xFFF5F9FD),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF475269).withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ]),
                          child: Row(children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10, right: 60, bottom: 10),
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFF475269),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                "http://${net}${item.product![0].image!}",
                                height: 80,
                                width: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${item.product![0].title}",
                                    style: TextStyle(
                                      color: Color(0xFF475269),
                                      fontSize: 20,
                                      // fontWeight: FontWeight.bold,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xFF475269),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                )
                                              ]),
                                          child: Text("${item.quantity}"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Provider.of<CartState>(context,
                                              listen: false)
                                          .deleteSingleCart(item.id);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF4752690),
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                            )
                                          ]),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$ ${item.price}",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        );
                      },
                    )),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F9FD),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF475269).withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 8)
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Fee:",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF475269)),
                              ),
                              Text(
                                "\$20",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF475269)),
                              ),
                            ],
                          ),
                          Divider(
                            height: 20,
                            thickness: 0.3,
                            color: Color(0xFF475269),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub-Total:",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF475269)),
                              ),
                              Text(
                                "\$${cart.total.toString()}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF475269)),
                              ),
                            ],
                          ),
                          Divider(
                            height: 20,
                            thickness: 0.3,
                            color: Color(0xFF475269),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount:",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF475269)),
                              ),
                              Text(
                                "-\$50",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.redAccent),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F9FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF475269).withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF475269),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "\$${cart.total.toString()}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: cart.cartproducts!.length <= 0
                          ? null
                          : () {
                              Navigator.of(context)
                                  .pushNamed(OrderNow.routeName);
                            },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFF475269),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Check Out",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}
