import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:point_shoot_resolve/pages/details_page_admin.dart';

import '../repository/requests_firestore.dart';
import '../model/request_data.dart';

class ViewRequestsAdmin extends StatefulWidget {
  final Future<List<RequestData>> requestData;
  final String department;
  final bool isAdmin;
  const ViewRequestsAdmin(
      {super.key, required this.requestData, required this.department, required this.isAdmin});

  @override
  State<ViewRequestsAdmin> createState() => _ViewRequestsAdminState();
}

class _ViewRequestsAdminState extends State<ViewRequestsAdmin> {
  String type = "All Requests";
  String departmentLocal = "";

  Future<List<RequestData>> updateRequestData(String type, String department) async {
    final req = RequestRepository();
    final Future<List<RequestData>> requests;
    if (department == "All") {
      if (type == "All Requests") {
        requests = req.getAllRequests();
      } else if (type == "Pending Requests") {
        requests = req.getAllRequestsPending();
      } else {
        requests = req.getAllRequestsResolved();
      }
    } else {
      if (type == "All Requests") {
        requests = req.getDepartmentRequests(department);
      } else if (type == "Pending Requests") {
        requests = req.getDepartmentRequestsPending(department);
      } else {
        requests = req.getDepartmentRequestsResolved(department);
      }
    }
    return requests;
  }

  Future<List<RequestData>>? requestDataLocal;

  @override
  void initState() {
    super.initState();
    departmentLocal = widget.department;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.black,
        // title: const Text("All Requests"),
        title: DropdownButton<String>(
            iconEnabledColor: Color.fromARGB(255, 255, 255, 255),
            // style: const TextStyle(color: Colors.white),
            value: type,
            dropdownColor: Colors.black,
            underline: Container(),
            items: <String>[
              "All Requests",
              "Pending Requests",
              "Resolved Requests"
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  ));
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                type = value!;
                requestDataLocal = updateRequestData(value, departmentLocal);
              });
            }),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      //Button is only rendered if the Main admin logs in. Else only department wise is visible
      floatingActionButton: widget.isAdmin ? SpeedDial(
        icon: departmentLocal == "All"
            ? Icons.list
            : departmentLocal == "Admin Office"
                ? Icons.assignment_ind_outlined
                : departmentLocal == "Plumbing Department"
                    ? Icons.plumbing_rounded
                    : departmentLocal == "Hardware Department"
                        ? Icons.hardware_rounded
                        : Icons.electrical_services_rounded,
        overlayOpacity: 0.7,
        overlayColor: const Color.fromARGB(77, 0, 0, 0),
        // animatedIcon: AnimatedIcons.menu_close,
        spacing: 8,
        children: [
          SpeedDialChild(
            child: Icon(Icons.list),
            label: "All",
            backgroundColor:
                departmentLocal == "All" ? Colors.green : Colors.white,
            onTap: () async {
              setState(() {
                departmentLocal = "All";
                requestDataLocal = updateRequestData(type, departmentLocal);
              });
              _showToast(context, "All Department");
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.assignment_ind_outlined),
            label: "Admin Office",
            backgroundColor:
                departmentLocal == "Admin Office" ? Colors.green : Colors.white,
            onTap: () {
              setState(() {
                departmentLocal = "Admin Office";
                requestDataLocal = updateRequestData(type, departmentLocal);
              });
              _showToast(context, departmentLocal);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.plumbing_rounded),
            label: "Plumbing Department",
            backgroundColor: departmentLocal == "Plumbing Department"
                ? Colors.green
                : Colors.white,
            onTap: () {
              setState(() {
                departmentLocal = "Plumbing Department";
                requestDataLocal = updateRequestData(type, departmentLocal);
              });
              _showToast(context, departmentLocal);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.hardware_rounded),
            label: "Hardware Department",
            backgroundColor: departmentLocal == "Hardware Department"
                ? Colors.green
                : Colors.white,
            onTap: () {
              setState(() {
                departmentLocal = "Hardware Department";
                requestDataLocal = updateRequestData(type, departmentLocal);
              });
              _showToast(context, departmentLocal);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.electrical_services_rounded),
            label: "Electrical Department",
            backgroundColor: departmentLocal == "Electrical Department"
                ? Colors.green
                : Colors.white,
            onTap: () {
              setState(() {
                departmentLocal = "Electrical Department";
                requestDataLocal = updateRequestData(type, departmentLocal);
              });
              _showToast(context, departmentLocal);
            },
          )
        ],
      ) : null,
      body: FutureBuilder<List<RequestData>>(
          future: requestDataLocal ?? widget.requestData,
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
              return Center(
                  child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ));
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
                                  builder: (context) => DetailsPageAdmin(
                                      userRequest: request, isAdmin: widget.isAdmin)));
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: request.department ==
                                        "Electrical Department"
                                    ? const AssetImage(
                                        "assets/images/electricity.png")
                                    : request.department ==
                                            "Plumbing Department"
                                        ? const AssetImage(
                                            "assets/images/plumbing.png")
                                        : request.department ==
                                                "Hardware Department"
                                            ? const AssetImage(
                                                "assets/images/hardware.png")
                                            : const AssetImage(
                                                "assets/images/administrator.png"),
                                fit: BoxFit
                                    .contain, // You can adjust the BoxFit property to control how the image fits within the container
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          request.name,
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

  void _showToast(BuildContext context, String department) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          content: Text('Showing $department requests',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600)),
          duration: const Duration(seconds: 3)),
    );
  }
}
