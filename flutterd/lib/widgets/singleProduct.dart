// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutterd/screens/product_detail_screen.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/network.dart';
import 'package:provider/provider.dart';

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
    return GridTile(
      header: GridTileBar(),
      child: Card(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              //in there of context is used to grab the instance of the product in context
              ProductDetailScreen.routeName,
              arguments: id,
            );
          },
          child: Image.network(
            "http://${net}$image",
            fit: BoxFit.fitWidth,
          ),
        ),
        // color: Colors.cyan[600],
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(title),
        leading: IconButton(
          onPressed: () {
            Provider.of<ProductState>(context, listen: false)
                .favouriteButton(id);
          },
          icon: Icon(
            favourite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
