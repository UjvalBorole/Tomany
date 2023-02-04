import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterd/screens/BottomCartSheet.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/app_drawer.dart';
import 'package:flutterd/widgets/singleProduct.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../state/cart_state.dart';

class FavouriteScreen extends StatelessWidget {
  static const routeName = '/favourite';
  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<ProductState>(context).favourites;
    final cart = Provider.of<CartState>(context).cartModel;

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
                        Provider.of<CartState>(context, listen: false)
                            .addToCart(favourite);
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
                        child: Badge(
                          badgeColor: Colors.redAccent,
                          padding: EdgeInsets.all(2),
                          badgeContent: Text(
                            "${cart?.cartproducts?.length ?? ''}",
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(
                            CupertinoIcons.cart_badge_plus,
                            color: Color(0xFF475269),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: 300, maxHeight: 800),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: favourite.length,
                          itemBuilder: (ctx, i) => SingleProduct(
                            id: favourite[i].id!,
                            title: favourite[i].title!,
                            image: favourite[i].image!,
                            favourite: favourite[i].favourite!,
                          ),
                        ),
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
      // drawer: AppDrawer(),
      //  ListView.builder(
      //     // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     //     childAspectRatio: 3 / 2,
      //     //     crossAxisCount: 2,
      //     //     crossAxisSpacing: 10,
      //     //     mainAxisSpacing: 10),
      //     scrollDirection: Axis.vertical,
      //     itemCount: favourite.length,
      //     itemBuilder: (ctx, i) => SingleProduct(
      //       id: favourite[i].id!,
      //       title: favourite[i].title!,
      //       image: favourite[i].image!,
      //       favourite: favourite[i].favourite!,
      //     ),
      //   ),
    );
  }
}
