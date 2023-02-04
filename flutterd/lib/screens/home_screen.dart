import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterd/screens/cart_screen.dart';
import 'package:flutterd/screens/profile.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:flutterd/widgets/app_drawer.dart';
import 'package:flutterd/widgets/searchbar.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../state/user_state.dart';
import '../widgets/appbar.dart';
import '../widgets/gridproduct.dart';
import '../widgets/singleProduct.dart';
import 'BottomCartSheet.dart';
import 'favourite_screen.dart';

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
      Provider.of<UserState>(context).ProfileUser();
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Color(0xFF475269),
                color: Color(0xFFF5F9FD),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
                width: 305,
                child: LinearProgressIndicator(
                  backgroundColor: Color(0xFF475269),
                  color: Color(0xFFF5F9FD),
                ),
              ),
            ],
          ),
        ),
      );
    else
      return Scaffold(
        body: SafeArea(
          // return SafeArea(
          //Custom AppBar
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Custom AppBar
                Appbar(),
                //Custom AppBar

                SizedBox(
                  height: 10,
                ),

                //Search Bar
                Searchbar(),
                //search Bar

                SizedBox(
                  height: 10,
                ),

                // ListView.builder(
                //         shrinkWrap: true,
                //         scrollDirection: Axis.horizontal,
                //         itemCount: prod.length,
                //         itemBuilder: (ctx, i) => SingleProduct(
                //           id: prod[i].id!,
                //           title: prod[i].title!,
                //           image: prod[i].image!,
                //           favourite: prod[i].favourite!,
                //         ),
                // ),

                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 300, maxHeight: 700),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.68,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    scrollDirection: Axis.vertical,
                    itemCount: prod.length,
                    itemBuilder: (ctx, i) => GridProduct(
                      id: prod[i].id!,
                      title: prod[i].title!,
                      image: prod[i].image!,
                      favourite: prod[i].favourite!,
                    ),
                  ),
                ),
                // AllItemsWidget(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Color(0xFF475269),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                },
                icon: Icon(
                  Icons.category_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              Badge(
                badgeColor: Colors.redAccent,
                padding: EdgeInsets.all(2),
                badgeContent: Text(
                  "${cart?.cartproducts?.length ?? ''}",
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  onPressed: () {
                    showSlidingBottomSheet(context, builder: (context) {
                      return SlidingSheetDialog(
                          elevation: 8,
                          cornerRadius: 16,
                          builder: (context, state) {
                            return BottomCartSheet();
                          });
                    });
                  },
                  icon: Icon(
                    CupertinoIcons.cart_fill,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(FavouriteScreen.routeName);
                },
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Profile.routeName);
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 32,
                ),
              )
            ],
          ),
        ),
      );
  }
}
