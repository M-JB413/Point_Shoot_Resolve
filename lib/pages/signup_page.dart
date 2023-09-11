//Feature has been deprecated.

import 'package:flutter/material.dart';
import "package:point_shoot_resolve/routes/routes.dart";
import "package:point_shoot_resolve/utils/constants/firebase_constants.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool _passwordVisiblePass = false;
  bool _passwordVisiblePassConf = false;
  bool _clicked = false;

  signUpValidator() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _clicked = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(context, MyRoutes.welcomeRoute);
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _clicked = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/images/black/signin_1.png",
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                  const Text(
                    "Sign Up!",
                    style: TextStyle(
                        fontSize: 23,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Solve your inconveniences today!",
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.3,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter Email ID",
                            labelText: "Username",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
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
                          obscureText: _passwordVisiblePass,
                          decoration: InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisiblePass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisiblePass =
                                        !_passwordVisiblePass;
                                  });
                                },
                              )),
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
                        TextFormField(
                          obscureText: !_passwordVisiblePassConf,
                          decoration: InputDecoration(
                              hintText: "Re-type Password",
                              labelText: "Confirm Password",
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisiblePassConf
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisiblePassConf =
                                        !_passwordVisiblePassConf;
                                  });
                                },
                              )),
                          validator: (value) {
                            if (confirmPassword.isEmpty) {
                              return "Password Cannot be empty";
                            } else if (password != confirmPassword) {
                              return "Password's must match";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            confirmPassword = value;
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () => signUpValidator(),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: _clicked ? 60 : 160,
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                borderRadius:
                                    BorderRadius.circular(_clicked ? 45 : 50)),
                            child: _clicked
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontSize: 15),
                                  ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
