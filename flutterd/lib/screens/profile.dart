import 'package:flutter/material.dart';
import 'package:flutterd/models/user.dart';
import 'package:flutterd/screens/login_screen.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class ProfileListItems extends StatelessWidget {
  final IconData icon;
  final text;
  final pagename;

  const ProfileListItems(
      {super.key,
      required this.icon,
      required this.text,
      required this.pagename});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 55,
      decoration: BoxDecoration(
        color: Color(0xFFF5F9FD),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Color(0xFF475269).withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 1),
        ],
      ),
      child: InkWell(
        onTap: (() {
          this.pagename
              ? Navigator.of(context).pushNamed(this.pagename.routeName)
              : "";
        }),
        child: Row(children: [
          Icon(
            this.icon,
            size: 27,
            color: Color(0xFF475269),
          ),
          SizedBox(width: 13),
          Container(
            width: 250,
            child: Text(
              this.text,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
          Spacer(),
          Icon(
            LineAwesomeIcons.angle_right,
            color: Color(0xFF475269),
            size: 30,
          )
        ]),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  static const routeName = '/profile-screen';
  LocalStorage storage = new LocalStorage('usertoken');

  void logoutnow(context) async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserState>(context).userdata;
    print("object");
    print(data);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
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
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 160,
                      width: 160,
                      child: Stack(alignment: Alignment.center, children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(100), // Image radius
                            child: Image.asset("assets/img/profile.jpg",
                                height: 300, width: 350, fit: BoxFit.cover),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10, right: 20),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.amber[300],
                                shape: BoxShape.circle),
                            child: Icon(
                              LineAwesomeIcons.pen,
                              color: Colors.white70,
                              size: 25,
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${data![0].username}",
                    style: TextStyle(fontSize: 20, color: Color(0xFFF5F9FD)),
                  ),
                  Text(
                    "He is a Decorator in the class",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 189, 194, 199)),
                  ),
                  Text(
                    "${data[0].email}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 189, 194, 199)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 90),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber[400]),
                    child: Center(
                      child: Text(
                        "Upgrade to PRO",
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                      child: Column(
                    children: [
                      ProfileListItems(
                          icon: LineAwesomeIcons.user_shield,
                          text: "privacy",
                          pagename: ""),
                      SizedBox(height: 20),
                      ProfileListItems(
                          icon: LineAwesomeIcons.history,
                          text: "Purchase History",
                          pagename: ""),
                      SizedBox(height: 20),
                      ProfileListItems(
                          icon: LineAwesomeIcons.question_circle,
                          text: "Help & Support",
                          pagename: ""),
                      SizedBox(height: 20),
                      ProfileListItems(
                          icon: LineAwesomeIcons.cog,
                          text: "Settings",
                          pagename: ""),
                      SizedBox(height: 20),
                      ProfileListItems(
                          icon: LineAwesomeIcons.user_plus,
                          text: "Invite a Friend",
                          pagename: ""),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F9FD),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF475269).withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 1),
                          ],
                        ),
                        child: InkWell(
                          onTap: (() {
                            logoutnow(context);
                          }),
                          child: Row(children: [
                            Icon(
                              LineAwesomeIcons.alternate_sign_out,
                              size: 27,
                              color: Color(0xFF475269),
                            ),
                            SizedBox(width: 13),
                            Container(
                              width: 250,
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              LineAwesomeIcons.angle_right,
                              color: Color(0xFF475269),
                              size: 30,
                            )
                          ]),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
