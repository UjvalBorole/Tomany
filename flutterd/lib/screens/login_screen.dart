// import 'package:ecom/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterd/screens/home_screen.dart';
import 'package:flutterd/screens/register_screen.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screens';

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  var _username = "";
  var _password = "";

  var username = TextEditingController();
  var password = TextEditingController();
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
                        return 'Enter the right Password';
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
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Color(0xFF475269),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _username = username.text;
                    _password = password.text;
                  });

                  bool istoken = await Provider.of<UserState>(
                    context,
                    listen: false,
                  ).loginNow(_username, _password);
                  if (istoken) {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login Successfully'),
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
                  'Don\'t Have Account? -',
                  style: TextStyle(
                    color: Color(0xFF475269).withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child: Text(
                    "Sign Up",
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
