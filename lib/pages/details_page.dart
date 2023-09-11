import 'package:flutter/material.dart';

import '../utils/requestData.dart';

class DetailsPage extends StatefulWidget {
  final RequestData userRequest;
  const DetailsPage({super.key, required this.userRequest});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
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
              child: Container(
                alignment: Alignment.center,
                height: 300,
                child: Image.network(widget.userRequest.imageURL),
                // radius: 140,
              ),
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Description: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16
                        // Add any other styles you want for the label here
                        ),
                  ),
                  TextSpan(
                      text: widget.userRequest.description,
                      style: const TextStyle(color: Colors.white, fontSize: 16)
                      // Add any styles you want for the description here
                      ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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
              height: 10,
            ),
            Text("Department: Plumbing Hardware Department",
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
