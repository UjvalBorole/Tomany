import 'package:flutter/material.dart';
import 'package:flutterd/screens/home_screen.dart';
import 'package:flutterd/screens/register_screen.dart';
import 'package:flutterd/state/user_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screens';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _username = "";
  var _password = "";

  var username = TextEditingController();
  var password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Login Now"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Card(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 40, top: 10, left: 20, right: 20),
                        child: Text(
                          "ToMany",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Username';
                            }
                            return null;
                          },
                          controller: username,
                          decoration: InputDecoration(
                            hintText: "Username",
                          ),
                          onSaved: (value) {
                            _username = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Username';
                            }
                            return null;
                          },
                          controller: password,
                          obscureText: true,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: "Password",
                          ),
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
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
                                  Navigator.of(context).pushReplacementNamed(
                                      HomeScreen.routeName);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Login Successfully'),
                                      backgroundColor: Colors.deepPurpleAccent,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'somethings went wrong, Try Again'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  RegisterScreen.routeName);
                            },
                            child: Text(
                              "Register New",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
