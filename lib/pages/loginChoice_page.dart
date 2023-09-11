// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:point_shoot_resolve/routes/routes.dart";
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:aad_oauth/aad_oauth.dart';
// import 'package:jwt_decode/jwt_decode.dart';
// import 'package:point_shoot_resolve/utils/constants/micrsoft_aad_constants.dart';
import 'package:point_shoot_resolve/providers/user_provider.dart';
import "package:provider/provider.dart";
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const LoginPage({Key? key, required this.navigatorKey}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

  // bool clicked = false;
  // bool _passwordVisibility = false;

  // final _formKey = GlobalKey<FormState>();

  // loginValidator() async {
  //   if (_formKey.currentState!.validate()) {
  //     // setState(() {
  //     //   clicked = true;
  //     // });
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     Navigator.pushNamed(context, MyRoutes.loggedIn);
  //     // await Future.delayed(const Duration(milliseconds: 500));
  //     // Navigator.pushNamed(context, MyRoutes.welcomeRoute);
  //     // Future.delayed(const Duration(seconds: 1), () {
  //     //   setState(() {
  //     //     clicked = false;
  //     //   });
  //     // });
  //   }
  // }

  // signOutFirebase() async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.pushNamed(context, MyRoutes.welcomeRoute);
  // }

  // signOut() async {
  //   final AadOAuth microsoftOauth =
  //       OAuthConfig.createMicrosoftOAuth(widget.navigatorKey);
  //   await microsoftOauth.logout();
  // }

  // loginWithMicrosoft() async {
  //   // final Config config = Config(
  //   //     tenant: 'common',
  //   //     clientId: 'bfb5dfec-a49d-4c7b-a51f-c466f28bf7cb',
  //   //     scope: 'openid profile offline_access',
  //   //     // redirectUri: "msalbfb5dfec-a49d-4c7b-a51f-c466f28bf7cb://auth",
  //   //     redirectUri: "https://login.live.com/oauth20_desktop.srf",
  //   //     navigatorKey: widget.navigatorKey,
  //   //     loader: SizedBox());

  //   // final AadOAuth microsoftOauth = AadOAuth(config);

  //   String username = "";
  //   // Map<String, dynamic> idTokenPayload = {};

  //   final AadOAuth microsoftOauth =
  //       OAuthConfig.createMicrosoftOAuth(widget.navigatorKey);

  //   final result = await microsoftOauth.login();
  //   result.fold(
  //     (l) => showError(l.toString()),
  //     (r) {
  //       // Decode the ID token to extract user information
  //       final idTokenPayload = Jwt.parseJwt(r.idToken!);
  //       Navigator.pushNamed(context, MyRoutes.loggedIn);
  //       showMessage(
  //           'Logged in successfully, your access token: ${idTokenPayload['upn']}');
  //     },
  //   );
  // }

  // void showError(dynamic ex) {
  //   showMessage(ex.toString());
  // }

  // void showMessage(String text) {
  //   var alert = AlertDialog(content: Text(text), actions: <Widget>[
  //     TextButton(
  //         child: const Text('Ok'),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         })
  //   ]);
  //   showDialog(context: context, builder: (BuildContext context) => alert);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) =>  Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/look.svg',
              height: 250,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login as...',  //To be decided -> Are you...
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Functionality for Student button
                      auth.signInWithMicrosoft();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'a Student',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'or',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, MyRoutes.adminLogin);
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginFormBW()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'an Admin',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Consumer<AuthProvider>(
  //     builder: (context, auth, child) => Material(
  //       color: Colors.white,
  //       child: SingleChildScrollView(
  //         padding: EdgeInsets.symmetric(vertical: 80),
  //         child: Form(
  //           key: _formKey,
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Image.asset(
  //                 "assets/images/black/login_1.png",
  //                 fit: BoxFit.cover,
  //                 height: 250,
  //               ),
  //               Text(
  //                 "Welcome Back!",
  //                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(
  //                 height: 40,
  //               ),
  //               Padding(
  //                   padding:
  //                       EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
  //                   child: Column(
  //                     children: [
  //                       TextFormField(
  //                         decoration: InputDecoration(
  //                           hintText: "Enter Email ID",
  //                           labelText: "Username",
  //                           labelStyle: TextStyle(
  //                               fontWeight: FontWeight.bold, fontSize: 14),
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Username cannot be empty";
  //                           }
  //                           return null;
  //                         },
  //                         onChanged: (value) {
  //                           email = value;
  //                           setState(() {});
  //                         },
  //                       ),
  //                       TextFormField(
  //                         obscureText: _passwordVisibility,
  //                         decoration: InputDecoration(
  //                             hintText: "Enter Password",
  //                             labelText: "Password",
  //                             labelStyle: TextStyle(
  //                                 fontWeight: FontWeight.bold, fontSize: 14),
  //                             suffixIcon: IconButton(
  //                               icon: Icon(_passwordVisibility
  //                                   ? Icons.visibility
  //                                   : Icons.visibility_off),
  //                               onPressed: () {
  //                                 setState(() {
  //                                   _passwordVisibility = !_passwordVisibility;
  //                                 });
  //                               },
  //                             )),
  //                         validator: (value) {
  //                           if (password.isEmpty) {
  //                             return "Password Cannot be empty";
  //                           }
  //                           return null;
  //                         },
  //                         onChanged: (value) {
  //                           password = value;
  //                           setState(() {});
  //                         },
  //                       ),
  //                       SizedBox(
  //                         height: 20,
  //                       ),
  //                       // InkWell(
  //                       //   child: Text(
  //                       //     "Don't have an account? Sign-Up Instead",
  //                       //     style: TextStyle(
  //                       //         color: const Color.fromARGB(255, 0, 0, 0),
  //                       //         fontWeight: FontWeight.bold),
  //                       //   ),
  //                       //   onTap: () {
  //                       //     Navigator.pushNamed(context, MyRoutes.signUpRoute);
  //                       //   },
  //                       // ),
  //                       // SizedBox(
  //                       //   height: 20,
  //                       // ),
  //                       InkWell(
  //                         onTap: () {
  //                           auth.setFormState(_formKey.currentState);
  //                           auth.signInWithEmailAndPassword(email, password);
  //                         },
  //                         child: AnimatedContainer(
  //                           duration: Duration(seconds: 1),
  //                           width: 160,
  //                           height: 45,
  //                           alignment: Alignment.center,
  //                           decoration: BoxDecoration(
  //                               color: const Color.fromARGB(255, 0, 0, 0),
  //                               borderRadius: BorderRadius.circular(50)),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               const Icon(
  //                                 Icons.login_rounded,
  //                                 color: Colors.white,
  //                               ),
  //                               SizedBox(
  //                                 width: 10,
  //                               ),
  //                               const Text(
  //                                 "Log In",
  //                                 style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontWeight: FontWeight.bold,
  //                                     letterSpacing: 2,
  //                                     fontSize: 15),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 20,
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           auth.signInWithMicrosoft();
  //                         },
  //                         child: AnimatedContainer(
  //                           duration: Duration(seconds: 1),
  //                           width: 260,
  //                           height: 45,
  //                           alignment: Alignment.center,
  //                           decoration: BoxDecoration(
  //                               color: const Color.fromARGB(255, 0, 0, 0),
  //                               borderRadius: BorderRadius.circular(50)),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               const Icon(
  //                                 Icons.login_rounded,
  //                                 color: Colors.white,
  //                               ),
  //                               // Image.asset(
  //                               //   'assets/images/microsoft.png', // Provide the correct image path
  //                               //   width: 24, // Set the desired width of the image
  //                               //   height:
  //                               //       24, // Set the desired height of the image
  //                               // ),
  //                               SizedBox(
  //                                 width: 10,
  //                               ),
  //                               const Text(
  //                                 "Log In with Microsoft",
  //                                 style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontWeight: FontWeight.bold,
  //                                     letterSpacing: 2,
  //                                     fontSize: 15),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ))
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
