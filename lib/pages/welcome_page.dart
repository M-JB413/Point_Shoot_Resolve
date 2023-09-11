import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/routes/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';  

//Old Code
// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   bool clicked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 50,
//           ),
//           Image.asset(
//             "assets/images/black/welcome_1.png",
//             fit: BoxFit.cover,
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Center(
//             child: Row(
//               children: [
//                 Image.asset(
//                   "assets/images/black/welcome_2.png",
//                   height: 200,
//                   width: 200,
//                   fit: BoxFit.contain,
//                 ),
//                 const Text(
//                   "Point, Shoot\nand Resolve",
//                   style: TextStyle(
//                       fontSize: 20,
//                       letterSpacing: 3,
//                       fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 50),
//             child: const Text(
//               "Your one stop to raise and resolve all your inconvienences. All you have to do is Point, Shoot and get it Resolved",
//               style: TextStyle(
//                   letterSpacing: 1.5,
//                   fontStyle: FontStyle.italic,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//           const SizedBox(
//             height: 60,
//           ),
//           InkWell(
//             onTap: () async {
//               setState(() {
//                 clicked = true;
//               });
//               await Future.delayed(const Duration(seconds: 1));
//               Navigator.pushNamed(context, MyRoutes.loginRoute);
//               await Future.delayed(const Duration(milliseconds: 1), () {
//                 setState(() {
//                   clicked = false;
//                 });
//               });
//             },
//             child: AnimatedContainer(
//               duration: const Duration(seconds: 1),
//               width: clicked ? 60 : 160,
//               height: 45,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 0, 0, 0),
//                   borderRadius: BorderRadius.circular(clicked ? 45 : 50)),
//               child: clicked
//                   ? const Icon(
//                       Icons.done,
//                       color: Colors.white,
//                     )
//                   : const Text(
//                       "Log In",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 2,
//                           fontSize: 15),
//                     ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

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

// class WelcomePage extends StatelessWidget {
//   const WelcomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black, 
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               'assets/home.svg', 
//               height: 200,
//             ),
//             const SizedBox(height: 50),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.all(10),
//                   child: const Icon(
//                     Icons.camera_alt,
//                     size: 40,
//                     color: Colors.black, 
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//                 const Text(
//                   'Point, Shoot and Resolve',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 23),
//             const Text(
//               'Your one stop to raise and resolve all your inconveniences. Just point, shoot and get it resolved!',
//               softWrap: true,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 33),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserTypeSelection()));
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: const Text(
//                 'Get Started',
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }