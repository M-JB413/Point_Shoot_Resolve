import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/pages/login_page.dart';
import 'package:point_shoot_resolve/pages/welcome_page.dart';
import 'package:point_shoot_resolve/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      initialRoute: '/welcome',
      routes: {
        MyRoutes.welcomeRoute : (context) => const WelcomePage(),
        MyRoutes.loginRoute : (context) => const LoginPage()
      },
    );
  }
}

