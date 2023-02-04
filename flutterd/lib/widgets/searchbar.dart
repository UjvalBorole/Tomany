import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      decoration: BoxDecoration(
          color: Color(0xFFF5F9FD),
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
          Container(
            width: 300,
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              // print('search');
            },
            child: Icon(
              Icons.search,
              size: 27,
              color: Color(0xFF475269),
            ),
          )
        ],
      ),
    );
  }
}
