import 'package:flutter/material.dart';
import 'package:flutterd/state/cart_state.dart';
import 'package:flutterd/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CartState>(context).oldOrder;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(data[index].email!),
                    Text(data[index].phone.toString()),
                    Text(data[index].address!),
                    Text("Total : ${data[index].cart!.total}"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
