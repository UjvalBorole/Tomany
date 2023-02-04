import 'package:flutter/material.dart';
import 'package:flutterd/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../state/user_state.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screens';
  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  var _email = "";
  var _username = "";
  var _password = "";
  var _conpassword = "";

  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final conpassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
              child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Image.asset("assets/img/login.png"),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xFFF5F9FD),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF475269).withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 1),
                ],
              ),
              child: Row(children: [
                Icon(
                  Icons.person,
                  size: 27,
                  color: Color(0xFF475269),
                ),
                SizedBox(width: 10),
                Container(
                  width: 250,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Username';
                      }
                      return null;
                    },
                    controller: username,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Username",
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xFFF5F9FD),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF475269).withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 1),
                ],
              ),
              child: Row(children: [
                Icon(
                  Icons.email_rounded,
                  size: 27,
                  color: Color(0xFF475269),
                ),
                SizedBox(width: 10),
                Container(
                  width: 250,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Corect email';
                      }
                      return null;
                    },
                    controller: email,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Email",
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xFFF5F9FD),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF475269).withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 1),
                ],
              ),
              child: Row(children: [
                Icon(
                  Icons.lock,
                  size: 27,
                  color: Color(0xFF475269),
                ),
                SizedBox(width: 10),
                Container(
                  width: 250,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Password';
                      }
                      return null;
                    },
                    controller: password,
                    obscureText: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Password",
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xFFF5F9FD),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF475269).withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 1),
                ],
              ),
              child: Row(children: [
                Icon(
                  Icons.lock_person,
                  size: 27,
                  color: Color(0xFF475269),
                ),
                SizedBox(width: 10),
                Container(
                  width: 250,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password Again';
                      } else if (conpassword.text != password.text) {
                        return 'Enter Right Password';
                      }
                      return null;
                    },
                    controller: conpassword,
                    obscureText: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Confirm Password",
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _email = email.text;
                    _username = username.text;
                    _password = password.text;
                    _conpassword = conpassword.text;
                  });

                  bool istoken = await Provider.of<UserState>(
                    context,
                    listen: false,
                  ).registernow(_username, _email, _password);
                  if (istoken) {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Signup Successfully'),
                        backgroundColor: Color(0xFF475269),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('somethings went wrong, Try Again'),
                        backgroundColor: Color(0xFF475269),
                      ),
                    );
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF475269),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF475269).withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ]),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already Have a Account? -',
                  style: TextStyle(
                    color: Color(0xFF475269).withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xFF475269),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ))),
    );
  }
}
