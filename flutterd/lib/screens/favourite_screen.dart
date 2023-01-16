import 'package:flutter/material.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/app_drawer.dart';
import 'package:flutterd/widgets/singleProduct.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  static const routeName = '/favourite';
  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<ProductState>(context).favourites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: AppDrawer(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: favourite.length,
        itemBuilder: (ctx, i) => SingleProduct(
          id: favourite[i].id!,
          title: favourite[i].title!,
          image: favourite[i].image!,
          favourite: favourite[i].favourite!,
        ),
      ),
    );
  }
}
