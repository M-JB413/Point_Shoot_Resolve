import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:point_shoot_resolve/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _passwordVisibility = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) => Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    child: SvgPicture.asset(
                      'assets/images/Admin-bro.svg',
                      height: 250,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.black,
                    child: Column(
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'User ID',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
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
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          obscureText: _passwordVisibility,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_passwordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisibility = !_passwordVisibility;
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
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: isLoading ? null : () async {
                              setState(() {
                                isLoading = true;
                              });
                              auth.setFormState(_formKey.currentState);
                              auth.signInWithEmailAndPassword(email, password, context)
                              .then((value) {
                                // Process completed successfully
                                setState(() {
                                  isLoading = false;
                                });
                              })
                              .catchError((error) {
                                // Handle errors here
                                // print("Error: $error");
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              fixedSize: const Size(120, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator() // Loading indicator
                                : const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
