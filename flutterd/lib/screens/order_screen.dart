import 'package:flutter/material.dart';
import 'package:flutterd/screens/cart_screen.dart';
import 'package:flutterd/screens/order_history_screen.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:provider/provider.dart';

class OrderNow extends StatefulWidget {
  static const routeName = '/order-now-screen';
  @override
  State<OrderNow> createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  String email = "";
  String phone = "";
  String add = "";

  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _add = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OrderNow"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
              key: _form,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 250),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(hintText: "Email"),
                          controller: _email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Email";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Mobile"),
                          controller: _phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Mobile";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Address"),
                          controller: _add,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (_form.currentState!.validate()) {
                                  setState(() {
                                    email = _email.text;
                                    phone = _phone.text;
                                    add = _add.text;
                                  });
                                }
                                final cart = Provider.of<CartState>(context,
                                        listen: false)
                                    .cartModel;

                                bool order = await Provider.of<CartState>(
                                        context,
                                        listen: false)
                                    .orderCart(cart!.id, add, email, phone);
                                if (order) {
                                  Navigator.of(context)
                                      .pushNamed(OrderScreen.routeName);
                                }
                              },
                              child: Text('Orders'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple[900]),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, CartScreen.routeName);
                              },
                              child: Text('Edit Cart'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple[500]),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
