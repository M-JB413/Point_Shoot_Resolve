// import "package:firebase_auth/firebase_auth.dart";
// import "package:flutter/material.dart";
// import "package:point_shoot_resolve/providers/user_provider.dart";
// import "package:point_shoot_resolve/routes/routes.dart";
// import "package:point_shoot_resolve/utils/user.dart";
// import "package:point_shoot_resolve/widgets/drawer.dart";
// import "package:provider/provider.dart";

// class AdminPage extends StatefulWidget {
//   const AdminPage({super.key});

//   @override
//   State<AdminPage> createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AdminPage> {
//   // final user = FirebaseAuth.instance.currentUser!;

//   // signOut() async {
//   //   await FirebaseAuth.instance.signOut();
//   //   Navigator.pushReplacementNamed(context, MyRoutes.welcomeRoute);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthProvider>(
//       builder: (context, authProvider, child) => Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.black,
//           title: const Center(
//             child: Text(
//               "Home Page",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2,
//                   color: Colors.white),
//             ),
//           ),
//         ),
//         body: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Welcome ${authProvider.getUser()!.emailID}!"),
//             SizedBox(
//               height: 10,
//             ),
//             InkWell(
//               onTap: () => authProvider.signOutFirebase(),
//               child: AnimatedContainer(
//                 duration: const Duration(seconds: 1),
//                 width: 160,
//                 height: 45,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 0, 0, 0),
//                     borderRadius: BorderRadius.circular(50)),
//                 child: const Text(
//                   "Log Out",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 2,
//                       fontSize: 15),
//                 ),
//               ),
//             )
//           ],
//         ),
//         drawer: const MyDrawer(),
//       ),
//     );
//     // return Material(
//     //   child: Center(
//     //     child: Text("You are logged in! $user"),
//     //   ),
//     // );
//   }
// }

import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/pages/view_requests_page.dart';
import 'package:point_shoot_resolve/providers/user_provider.dart';
import 'package:point_shoot_resolve/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../repository/requests_firestore.dart';
import '../model/request_data.dart';

class HomePageStudent extends StatefulWidget {
  const HomePageStudent({super.key});

  @override
  State<HomePageStudent> createState() => _HomePageStudentState();
}

class _HomePageStudentState extends State<HomePageStudent> {
  final req = RequestRepository();

  void viewRequests(String? rollNo) async {
    final Future<List<RequestData>> requests = req.getUserRequests(rollNo!);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ViewRequests(requestData: requests)));

    // Navigator.pushNamed(context, MyRoutes.viewRequest);
  }

  // void viewRequestsAdmin() async {
  //   final Future<List<RequestData>> allRequests = req.getAllRequests();

  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => ViewRequestsAdmin(requestData: allRequests)));
  // }

  // void viewRequestsDepartment(String? department) async {
  //   final Future<List<RequestData>> allRequests = req.getAllRequests();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Point, Shoot and Resolve'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: SvgPicture.asset(
                  'assets/images/Maintenance-cuate.svg',
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome, ${authProvider.getUser()!.name}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 5),
              Text(
                '${authProvider.getUser()!.emailID}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 40,
              ),
              if (authProvider.getUser()!.designation == "Student")
                ElevatedButton(
                  onPressed: () async {
                    //navigation logic here
                    Navigator.pushNamed(context, MyRoutes.postRequest_1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    fixedSize: Size(200, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Post Request',
                    style: TextStyle(fontSize: 18, letterSpacing: 1.2),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // navigation logic here
                  viewRequests(authProvider.getUser()!.rollNo);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  fixedSize: Size(200, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'View Requests',
                  style: TextStyle(fontSize: 18, letterSpacing: 1.2),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  //navigation logic here
                  await authProvider.signOutMicrosoft();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  fixedSize: Size(200, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 17, letterSpacing: 1.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    //Old Code
    // return Consumer<AuthProvider>(
    //   builder: (context, authProvider, child) => Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //       automaticallyImplyLeading: false,
    //       backgroundColor: Colors.black,
    //       title: const Center(
    //         child: Text(
    //           "Home Page",
    //           style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //               letterSpacing: 2,
    //               color: Colors.white),
    //         ),
    //       ),
    //     ),
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           CircleAvatar(
    //             radius: 80,
    //             backgroundImage: NetworkImage(imageURL),
    //           ),
    //           const SizedBox(height: 20),
    //           Text(
    //             '${authProvider.getUser()!.name}', // Replace with the user's name
    //             style: const TextStyle(
    //               fontSize: 24,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           Text(
    //             '${authProvider.getUser()!.emailID}', // Replace with the user's email
    //             style: const TextStyle(
    //               fontSize: 18,
    //               color: Colors.grey,
    //             ),
    //           ),
    //           const SizedBox(height: 30),
    //           ElevatedButton(
    //             onPressed: () {
    //               // Add your logic for "Post a complaint" here
    //             },
    //             style: ButtonStyle(
    //                 backgroundColor:
    //                     MaterialStateProperty.all<Color>(Colors.black),
    //                 foregroundColor:
    //                     MaterialStateProperty.all<Color>(Colors.white)),
    //             child: authProvider.getUser()!.designation != "Student"
    //                 ? const Text('Post a complaint')
    //                 : const Text('Resolve Complaints'),
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               // Add your logic for "View past complaints" here
    //             },
    //             style: ButtonStyle(
    //                 backgroundColor:
    //                     MaterialStateProperty.all<Color>(Colors.black),
    //                 foregroundColor:
    //                     MaterialStateProperty.all<Color>(Colors.white)),
    //             child: const Text('View past complaints'),
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           ElevatedButton(
    //             onPressed: () async {
    //               // Add your logic for "Log Out" here
    //               authProvider.getUser()!.designation != "Student"
    //                   ? await authProvider.signOutFirebase()
    //                   : await authProvider.signOutMicrosoft();
    //             },
    //             style: ButtonStyle(
    //                 backgroundColor:
    //                     MaterialStateProperty.all<Color>(Colors.black),
    //                 foregroundColor:
    //                     MaterialStateProperty.all<Color>(Colors.white)),
    //             child: const Text('Log Out'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
