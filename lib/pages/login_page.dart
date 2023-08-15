// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:point_shoot_resolve/routes/routes.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool clicked = false;

  final _formKey = GlobalKey<FormState>();

  loginValidator() async {
    if(_formKey.currentState!.validate()){
      setState(() {
        clicked = true;
      });
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pushNamed(context, MyRoutes.welcomeRoute);
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          clicked = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "assets/images/login_1.png",
                  fit: BoxFit.cover,
                  height: 250,
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter Email ID",
                            labelText: "Username",
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                            setState(() {});
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Password",
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          validator: (value) {
                            if (password.isEmpty) {
                              return "Password Cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          child: Text(
                            "Need Help Signing In?  (change route)",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, MyRoutes.welcomeRoute);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => loginValidator(),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: clicked ? 60 : 160,
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.circular(clicked ? 45 : 50)),
                            child: clicked
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Log In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontSize: 15),
                                  ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
