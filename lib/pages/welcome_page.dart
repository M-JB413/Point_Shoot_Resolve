import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/routes/routes.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/images/welcome_1.png",
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Row(
              children: [
                Image.asset(
                  "assets/images/welcome_2.png",
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                const Text(
                  "Point, Shoot\nand Resolve",
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: const Text(
              "Your one stop to raise and resolve all your inconvienences. All you have to do is Point, Shoot and get it Resolved",
              style: TextStyle(
                  letterSpacing: 1.5,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                clicked = true;
              });
              await Future.delayed(const Duration(seconds: 1));
              Navigator.pushNamed(context, MyRoutes.loginRoute);
              await Future.delayed(const Duration(milliseconds: 1), () {
                setState(() {
                  clicked = false;
                });
              });
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: clicked ? 60 : 160,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(clicked ? 45 : 50)),
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
      ),
    );
  }
}
