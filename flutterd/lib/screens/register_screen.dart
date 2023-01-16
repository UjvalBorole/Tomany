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
  var _username = "";
  var _password = "";
  var _conpassword = "";

  final username = TextEditingController();
  final password = TextEditingController();
  final conpassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Signup Now"),
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
                              return 'Enter Your Password';
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 10),
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
                            hintText: "Confirm Password",
                          ),
                          onSaved: (value) {
                            _conpassword = value!;
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
                                  _conpassword = conpassword.text;
                                });

                                bool istoken = await Provider.of<UserState>(
                                  context,
                                  listen: false,
                                ).registernow(_username, _password);
                                if (istoken) {
                                  Navigator.of(context).pushReplacementNamed(
                                      LoginScreen.routeName);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Signup Successfully'),
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
                              "Signup",
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text(
                              "Login",
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
