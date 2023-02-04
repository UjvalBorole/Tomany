// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterd/screens/product_detail_screen.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/network.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';

class GridProduct extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final bool favourite;

  GridProduct({
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
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      margin: EdgeInsets.only(left: 10, right: 15, top: 25),
      // margin: EdgeInsets.all(0),
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
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                //in there of context is used to grab the instance of the product in context
                ProductDetailScreen.routeName,
                arguments: id,
              );
            },
            child: Container(
              child: Image.network(
                "http://${net}$image",
                height: 110,
                width: 100,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Container(
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF475269),
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
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 20,
              child: Text(
                "${product.description}",
                style: TextStyle(
                    fontSize: 15, color: Color(0xFF475269).withOpacity(0.7)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.sellingPrice}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<CartState>(context, listen: false)
                        .addToCart(id);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFF475269),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      CupertinoIcons.cart_fill_badge_plus,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
