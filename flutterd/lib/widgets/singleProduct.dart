// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterd/screens/product_detail_screen.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/network.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';

class SingleProduct extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final bool favourite;

  SingleProduct({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.favourite,
  }) : super(key: key);

  var net = Network.network;

  Widget build(BuildContext context) {
    final product = Provider.of<ProductState>(context).SingleProduct(id);

    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10),
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
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                //in there of context is used to grab the instance of the product in context
                ProductDetailScreen.routeName,
                arguments: id,
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  // color: Colors.red,
                  height: 130,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Color(0xFF475269),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Image.network("http://${net}$image",
                    height: 100, width: 150, fit: BoxFit.contain)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: 230,
              // height: 150,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${title}",
                        style: TextStyle(
                          color: Color(0xFF475269),
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(0),
                        child: IconButton(
                          onPressed: () {
                            Provider.of<ProductState>(context, listen: false)
                                .favouriteButton(id);
                          },
                          icon: Icon(
                            favourite ? Icons.favorite : Icons.favorite_border,
                            color: Color(0xFF475269),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 20,
                      width: 200,
                      child: Text(
                        "${product.description}...",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF475269).withOpacity(0.7)),
                      ),
                    ),
                  ),
                  // Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "\$${product.sellingPrice}",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<CartState>(context, listen: false)
                              .addToCart(id);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFF475269),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            CupertinoIcons.cart_fill_badge_plus,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
