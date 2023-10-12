import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/repository/requests_firestore.dart';

import '../model/request_data.dart';
import 'home_page_admin.dart';

class DetailsPageAdmin extends StatefulWidget {
  final RequestData userRequest;
  final bool isAdmin;
  const DetailsPageAdmin(
      {super.key, required this.userRequest, required this.isAdmin});

  @override
  State<DetailsPageAdmin> createState() => _DetailsPageAdminState();
}

class _DetailsPageAdminState extends State<DetailsPageAdmin> {

  bool isLoading = false;


  Future<void> resolveComplaint(BuildContext context) async {
    // final id = widget.userRequest.id;
    // final req = RequestRepository();
    // req.resolveComplaint(widget.userRequest);

    // final Future<List<RequestData>> requests;
    // requests = req.getDepartmentRequestsResolved(widget.userRequest.department);
    // List<RequestData> requestDataList = await requests;
    // RequestData data =
    //     requestDataList.firstWhere((request) => request.id == id);

    // Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsPageAdmin(
    //   userRequest: data, isAdmin: widget.isAdmin)));

    try {
      setState(() {
        isLoading = true; // Set isLoading to true when starting the operation
      });

      final id = widget.userRequest.id;
      final req = RequestRepository();
      await req.resolveComplaint(widget.userRequest);

      final Future<List<RequestData>> requests;
      requests = req.getDepartmentRequestsResolved(widget.userRequest.department);
      List<RequestData> requestDataList = await requests;
      RequestData data =
          requestDataList.firstWhere((request) => request.id == id);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailsPageAdmin(
        userRequest: data, isAdmin: widget.isAdmin)));
    } catch (error) {
      // Handle any errors here
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false; // Set isLoading back to false when the operation is completed
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requested on ${widget.userRequest.date}"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: isLoading ? const Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("Updating Entry...", style: TextStyle(fontSize: 15, color: Colors.white),)
            ],
          ),
        ),
      ) : SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 300,
                      child: Image.network(widget.userRequest.imageURL),
                      // radius: 140,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Location: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12
                                // Add any other styles you want for the label here
                                ),
                          ),
                          TextSpan(
                              text: widget.userRequest.location,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12)
                              // Add any styles you want for the description here
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Name: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          TextSpan(
                              text: widget.userRequest.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Roll No: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          TextSpan(
                              text: widget.userRequest.rollNo,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Description: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          TextSpan(
                              text: widget.userRequest.description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Department: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16
                                // Add any other styles you want for the label here
                                ),
                          ),
                          TextSpan(
                              text: widget.userRequest.department,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)
                              // Add any styles you want for the description here
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Status: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16
                                // Add any other styles you want for the label here
                                ),
                          ),
                          TextSpan(
                              text: widget.userRequest.isResolved == true
                                  ? "Resolved"
                                  : "Pending",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)
                              // Add any styles you want for the description here
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!(widget.userRequest.isResolved) && !(widget.isAdmin))
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      //navigation logic here
                      //Update status to resolved and reload page
                      resolveComplaint(context);
                      //Write some logic to reflect the update
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      fixedSize: const Size(120, 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Resolve!',
                      style: TextStyle(fontSize: 15, letterSpacing: 1.2),
                    ),
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
