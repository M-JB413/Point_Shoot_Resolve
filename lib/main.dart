import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/pages/image_capture.dart';
import 'package:point_shoot_resolve/pages/loginAdmin_page.dart';
import 'package:point_shoot_resolve/pages/loginChoice_page.dart';
import 'package:point_shoot_resolve/pages/home_page_student.dart';
import 'package:point_shoot_resolve/pages/signup_page.dart';
import 'package:point_shoot_resolve/pages/submit_form.dart';
import 'package:point_shoot_resolve/pages/view_requests_page.dart';
import 'package:point_shoot_resolve/pages/welcome_page.dart';
import 'package:point_shoot_resolve/providers/user_provider.dart';
import 'package:point_shoot_resolve/routes/routes.dart';
import 'package:provider/provider.dart';
import 'utils/constants/firebase_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
  Flow of the app;
    1. welcome_page.dart
    2. loginChoice_page.dart
      | Either directly authenticated using Microsoft Azure AD
      | Login using Firebase -> loginAdmin_page.dart
    3. home_page.dart
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");
  await firebaseInitialization;
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthProvider(navigatorKey: navigatorKey))
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(primarySwatch: Colors.grey),
        initialRoute: '/welcome',
        routes: {
          MyRoutes.welcomeRoute: (context) => const WelcomePage(),
          MyRoutes.loginRoute: (context) => LoginPage(navigatorKey: navigatorKey),
          MyRoutes.signUpRoute: (context) => const SignUpPage(),
          MyRoutes.loggedInStudent: (context) => const HomePageStudent(),
          MyRoutes.adminLogin: (context) => const AdminLogin(),
          MyRoutes.postRequest_1: (context) => const CaptureImage(),
          MyRoutes.postRequest_2: (context) => const FillDetails(),
          MyRoutes.viewRequest: (context) => const ViewRequests()
        },
      ),
    );
  }
}
