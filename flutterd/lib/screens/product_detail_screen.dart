import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterd/models/product.dart';
import 'package:flutterd/screens/cart_screen.dart';
import 'package:flutterd/screens/order_history_screen.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/network.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:velocity_x/velocity_x.dart';

import 'BottomCartSheet.dart';

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
    final fav =
        Provider.of<ProductState>(context).products; //ProductState.products

    // print(id);
    final cart = Provider.of<CartState>(context).cartModel;

    final product = Provider.of<ProductState>(context).SingleProduct(id);
    bool toggle = true;
    bool change = true;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        //Goes back
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F9FD),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF475269).withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Color(0xFF475269),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<ProductState>(context, listen: false)
                            .favouriteButton(product.id!);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F9FD),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF475269).withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(
                          product.favourite!
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Color(0xFF475269),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                // height: MediaQuery.of(context).size.height * 0.43,
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    height: 300,
                    width: 350,
                    margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF475269),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        "http://${net}${product.image}",
                        height: 200,
                        width: 280,
                        fit: BoxFit.contain,
                      ))
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                    color: Color(0xFFF5F9FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF475269).withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.title}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            '${product.sellingPrice.toString()}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: RatingBar.builder(
                          initialRating: 3,
                          maxRating: 1,
                          direction: Axis.horizontal,
                          itemSize: 20,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 218, 218, 56),
                          ),
                          onRatingUpdate: (index) {},
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${product.description}',
                        style:
                            TextStyle(color: Color(0xFF475269), fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        //   ],
        // ),
      ),
      // ),
      bottomNavigationBar: Container(
        color: Color(0xFFF5F9FD),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Provider.of<CartState>(context, listen: false).addToCart(id);
                showSlidingBottomSheet(context, builder: (context) {
                  return SlidingSheetDialog(
                      elevation: 8,
                      cornerRadius: 16,
                      builder: (context, state) {
                        return BottomCartSheet();
                      });
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                    color: Color(0xFF475269),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF475269).withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      )
                    ]),
                child: Row(
                  children: [
                    Text(
                      "Add To Cart",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Badge(
                      badgeColor: Colors.redAccent,
                      padding: EdgeInsets.all(2),
                      badgeContent: Text(
                        "${cart?.cartproducts?.length ?? ''}",
                        style: TextStyle(color: Colors.white),
                      ),
                      // child: IconButton(
                      //     icon: (toggle == true)
                      //         ? Icon(CupertinoIcons.cart_badge_plus)
                      //         : Icon(
                      //             Icons.done,
                      //           ),
                      //     onPressed: () {
                      //       Provider.of<CartState>(context, listen: false)
                      //           .addToCart(id);

                      //       setState(() {
                      //         toggle = false;
                      //       });
                      //     }),
                      child: Icon(
                        CupertinoIcons.cart_badge_plus,
                        color: Colors.white,
                        size: 32,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName);
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Color(0xFF475269),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF475269).withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ]),
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                    size: 32,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
