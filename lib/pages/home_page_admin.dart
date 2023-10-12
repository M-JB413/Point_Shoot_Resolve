import 'package:flutter/material.dart';
import 'package:point_shoot_resolve/pages/view_requests_admin_page.dart';
import 'package:point_shoot_resolve/pages/view_requests_page.dart';
import 'package:point_shoot_resolve/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

import '../repository/requests_firestore.dart';
import '../model/request_data.dart';

class HomePageAdmin extends StatefulWidget {
  final String dept;
  HomePageAdmin({super.key, required this.dept});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  String? _selectedPendingDropdownValue; // Set default value to 'All'

  final req = RequestRepository();
  int resolvedCount = 0;
  int unResolvedCount = 0;

  bool isLoading = false;

  bool isAdmin = false;

  void getCount(String department) async {
    setState(() {
      isLoading = true;
    });

    final Future<List<RequestData>> dataResolved;
    final Future<List<RequestData>> dataNotResolved;

    if (department == "All") {
      dataResolved = req.getAllRequestsResolved();
      dataNotResolved = req.getAllRequestsPending();
    } else {
      dataResolved = req.getDepartmentRequestsResolved(department);
      dataNotResolved = req.getDepartmentRequestsPending(department);
    }

    List<RequestData> requestDataListR = await dataResolved;
    List<RequestData> requestDataListNR = await dataNotResolved;

    resolvedCount = requestDataListR.length;
    unResolvedCount = requestDataListNR.length;

    setState(() {
      isLoading = false;
    });
  }

  void viewRequests(String? rollNo) async {
    final Future<List<RequestData>> requests = req.getUserRequests(rollNo!);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ViewRequests(requestData: requests)));

    // Navigator.pushNamed(context, MyRoutes.viewRequest);
  }

  void viewRequestsAdmin() async {
    final Future<List<RequestData>> allRequests = req.getAllRequests();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ViewRequestsAdmin(
              requestData: allRequests,
              department: "All",
              isAdmin: true,
            )));
  }

  void viewRequestsDepartment(String? department, bool isAdmin) async {
    final Future<List<RequestData>> allRequests =
        req.getDepartmentRequests(department!);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ViewRequestsAdmin(
              requestData: allRequests,
              department: department,
              isAdmin: isAdmin,
            )));
  }

  @override
  void initState() {
    super.initState();
    if (widget.dept == "Admin") {
      _selectedPendingDropdownValue = "All";
    } else {
      _selectedPendingDropdownValue = widget.dept;
    }
    getCount(_selectedPendingDropdownValue!);

    //Fetch from Firestore and store data
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCount(_selectedPendingDropdownValue!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Point, Shoot and Resolve'),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.cloud_sync_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                // Updating local memory or cache
                /*
              Do I load all the data from all departments at once - Seems to be the more seamless option
              For the admin - Download all the data
              For the departments - Download only the department data

               */
                getCount(_selectedPendingDropdownValue!);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 30)),
                Text(
                  'Welcome, ${authProvider.getUser()!.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${authProvider.getUser()!.emailID}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 40),
                // Circular chart
                Center(
                  child: isLoading
                      ? const CircularProgressIndicator() // Show the loading indicator
                      : PieChart(
                          dataMap: {
                            'Pending requests - $unResolvedCount':
                                unResolvedCount.toDouble(),
                            'Resolved requests - $resolvedCount':
                                resolvedCount.toDouble(),
                          },
                          animationDuration: const Duration(seconds: 1),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 2.85,
                          colorList: const [
                            Colors.red,
                            Colors.green
                          ], // Reversed the color order
                          chartType: ChartType.ring,
                          centerText: "Progress",
                          legendOptions: const LegendOptions(
                            showLegends: true,
                            legendPosition: LegendPosition.bottom,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .white, // Set legend text color to white
                            ),
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValues: false,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                            chartValueStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                // Pending Requests Dropdown
                //can be rendered only if name == admin
                if (authProvider.getUser()!.name == "Admin")
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Pending requests',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: Colors.black,
                        value: _selectedPendingDropdownValue,
                        items: <String>[
                          'All',
                          'Admin Office',
                          'Electrical Department',
                          'Plumbing Department',
                          'Hardware Department',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedPendingDropdownValue = newValue;
                            getCount(newValue!);
                          });
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    //navigation logic here
                    if (_selectedPendingDropdownValue == "All") {
                      viewRequestsAdmin();
                    } else {
                      if (authProvider.getUser()!.name == "Admin") {
                        isAdmin = true;
                      }
                      viewRequestsDepartment(
                          _selectedPendingDropdownValue, isAdmin);
                    }
                    // Navigator.of(context).push(MaterialPageRoute(
                    // builder: (context) => Temp()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    fixedSize: const Size(200, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'View Requests',
                    style: TextStyle(fontSize: 17, letterSpacing: 1.2),
                  ),
                ),
                const SizedBox(height: 20),
                // Logout Button
                ElevatedButton(
                  onPressed: () async {
                    //navigation logic here
                    await authProvider.signOutFirebase();
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
      ),
    );
  }
}
