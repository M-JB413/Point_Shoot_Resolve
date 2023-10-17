import 'package:flutter/material.dart';

import '../model/request_data.dart';

class DetailsPageStudent extends StatefulWidget {
  final RequestData userRequest;
  const DetailsPageStudent({super.key, required this.userRequest});

  @override
  State<DetailsPageStudent> createState() => _DetailsPageStudentState();
}

class _DetailsPageStudentState extends State<DetailsPageStudent> {
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
      body: Center(
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
                              style: const TextStyle(color: Colors.white, fontSize: 12)
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
                          text: 'Description: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16
                              ),
                        ),
                        TextSpan(
                          text: widget.userRequest.description,
                          style: const TextStyle(color: Colors.white, fontSize: 16)
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
                            style: const TextStyle(color: Colors.white, fontSize: 16)
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
                            text: widget.userRequest.isResolved == true ? "Resolved" : "Pending",
                            style: const TextStyle(color: Colors.white, fontSize: 16)
                            // Add any styles you want for the description here
                            ),
                      ],
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
}
