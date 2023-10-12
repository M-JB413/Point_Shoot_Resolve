import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/routes/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';  

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/home.svg', 
              height: 250,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Colors.black, 
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Point, Shoot and Resolve',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 23),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: const Text(
                'Your one stop to raise and resolve all your inconveniences. Just point, shoot and get it resolved!',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            const SizedBox(height: 33),
            ElevatedButton(
              onPressed: () async{
                Navigator.pushNamed(context, MyRoutes.loginRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}