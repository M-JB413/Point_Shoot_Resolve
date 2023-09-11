import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/pages/image_capture.dart';
import 'package:point_shoot_resolve/pages/loginAdmin_page.dart';
import 'package:point_shoot_resolve/pages/loginChoice_page.dart';
import 'package:point_shoot_resolve/pages/home_page.dart';
import 'package:point_shoot_resolve/pages/signup_page.dart';
import 'package:point_shoot_resolve/pages/submit_form.dart';
import 'package:point_shoot_resolve/pages/view_requests_page.dart';
import 'package:point_shoot_resolve/pages/welcome_page.dart';
import 'package:point_shoot_resolve/providers/user_provider.dart';
import 'package:point_shoot_resolve/routes/routes.dart';
import 'package:provider/provider.dart';
import 'utils/constants/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // ignore: unnecessary_string_escapes
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
          MyRoutes.loginRoute: (context) =>
              LoginPage(navigatorKey: navigatorKey),
          // MyRoutes.loginRoute: (context) {
          //   return StreamBuilder<User?>(
          //     stream: FirebaseAuth.instance.authStateChanges(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return const AdminPage();
          //       } else {
          //         return LoginPage(navigatorKey: navigatorKey);
          //       }
          //     },
          //   );
          //Remember to remove this return statement and make it return StreamBuilder
          //This ensures that till the user logs out, the state is maintained.
          // return const LoginPage();
          // },
          MyRoutes.signUpRoute: (context) => const SignUpPage(),
          MyRoutes.loggedIn: (context) => const AdminPage(),
          MyRoutes.adminLogin: (context) => const AdminLogin(),
          MyRoutes.postRequest_1: (context) => const CaptureImage(),
          MyRoutes.postRequest_2: (context) => const FillDetails(),
          MyRoutes.viewRequest: (context) => const ViewRequests()

          /*
            MyRoutes.loginRoute: (context) {
              if (FirebaseAuth.instance.currentUser != null) {
                return const AdminPage();
              } else {
                return LoginPage();
              }
            },
    
            MyRoutes.loginRoute: (context) {
              return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const AdminPage();
                  } else {
                    return const LoginPage();
                  }
                },
              );
            },
          */
        },
      ),
    );
  }
}
