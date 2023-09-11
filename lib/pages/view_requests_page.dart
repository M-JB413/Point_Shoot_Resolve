import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/pages/details_page.dart';
import 'package:point_shoot_resolve/utils/requestData.dart';

import '../repository/requests_firestore.dart';

class ViewRequests extends StatefulWidget {
  final Future<List<RequestData>>? requestData;

  const ViewRequests({super.key, this.requestData});

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  var arrNums = ["One", "Two", "Three", "Four", "Five", "Six", "Seven"];
  final imageURL =
      "https://firebasestorage.googleapis.com/v0/b/psr-firebase.appspot.com/o/Uploads%2F4f336fd3-1a91-410f-84eb-8a0b9700ab1f5188953137647977377.jpg?alt=media&token=46b8c0a8-ae0d-456d-887f-c2b68c40fa24";

  // final req = RequestRepository();

  // final List<RequestData> requests = req.getUserRequests()

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
      backgroundColor: Colors.white,
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
                      style: TextStyle(fontSize: 15),
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
                                  builder: (context) => DetailsPage(userRequest: request)));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(request.imageURL),
                        ),
                        title: Text(
                          request.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          request.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(height: 1.3),
                        ),
                        // isThreeLine: true,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(request.date,
                                style: const TextStyle(fontSize: 12)),
                            // Text("8:18pm", style: TextStyle(fontSize: 12))
                          ],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    // return Padding(padding: EdgeInsets.all(8.0));
                    return const Divider(
                      height: 30,
                      color: Color.fromARGB(27, 0, 0, 0),
                      thickness: 1.2,
                    );
                  },
                  itemCount: requestData.length);
            }
          }),
    );
  }
}
