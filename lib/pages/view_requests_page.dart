import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:point_shoot_resolve/pages/details_page_student.dart';
import 'package:point_shoot_resolve/model/request_data.dart';

import '../repository/requests_firestore.dart';

class ViewRequests extends StatefulWidget {
  final Future<List<RequestData>>? requestData;

  const ViewRequests({super.key, this.requestData});

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  // final req = RequestRepository();

  // final List<RequestData> requests = req.getUserRequests()

  // ImageProvider<Object>? getSVG(String department) {
  //   AssetImage image;
  //   if (department == "Electrical Department") {
  //     image = AssetImage("assets/images/light-bulb-svgrepo-com.svg");
  //   } else if (department == "Plumbing Department") {
  //     image = AssetImage("assets/images/water-tap-plumber-svgrepo-com.svg");
  //   } else if (department == "Hardware Department") {
  //     image = AssetImage("assets/images/hardware-svgrepo-com.jpg");
  //   } else {
  //     image = AssetImage("assets/images/admin-users-svgrepo-com.svg");
  //   }

  //   return image;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text("View Request"),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<RequestData>>(
          future: widget.requestData!,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please wait while we fetch your data...",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<RequestData> requestData = snapshot.data!;
              return ListView.separated(
                  padding: const EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) {
                    RequestData request = requestData[index];
                    return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPageStudent(userRequest: request)));
                        },
                        // leading: CircleAvatar(
                        //     // backgroundColor: Colors.black,
                        //     backgroundImage: request.department ==
                        //             "Electrical Department"
                        //         ? const AssetImage(
                        //             "assets/images/electricity.png")
                        //         : request.department == "Plumbing Department"
                        //             ? const AssetImage(
                        //                 "assets/images/plumbing.png")
                        //             : request.department == "Hardware Department"
                        //                 ? const AssetImage(
                        //                     "assets/images/hardware.png")
                        //                 : const AssetImage(
                        //                     "assets/images/administrator.png"),
                            
                        //   ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Container(
                            width: 30, 
                            height: 30, 
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: request.department == "Electrical Department"
                                    ? const AssetImage("assets/images/electricity.png")
                                    : request.department == "Plumbing Department"
                                        ? const AssetImage("assets/images/plumbing.png")
                                        : request.department == "Hardware Department"
                                            ? const AssetImage("assets/images/hardware.png")
                                            : const AssetImage("assets/images/administrator.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          request.department,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                        subtitle: Text(
                          request.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(height: 1.3, color: Colors.white),
                        ),
                        // isThreeLine: true,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(request.date,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            const SizedBox(height: 10,),
                            request.isResolved 
                              ? const Text(
                                  "Resolved", 
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  )
                                )
                              : const Text(
                                  "Not Resolved", 
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                            // Text("8:18pm", style: TextStyle(fontSize: 12))
                          ],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    // return Padding(padding: EdgeInsets.all(8.0));
                    return const Divider(
                      height: 30,
                      color: Color.fromARGB(48, 153, 152, 152),
                      thickness: 1.2,
                    );
                  },
                  itemCount: requestData.length);
            }
          }),
    );
  }
}
