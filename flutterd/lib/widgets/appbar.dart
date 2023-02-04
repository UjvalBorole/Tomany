import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.sort,
                size: 30,
                color: Color(0xFF475269),
              ),
            ),
          ),
          Container(
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
                "3",
                style: TextStyle(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.notifications,
                  size: 30,
                  color: Color(0xFF475269),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
