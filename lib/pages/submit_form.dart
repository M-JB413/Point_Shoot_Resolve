import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:point_shoot_resolve/providers/user_provider.dart';
import 'package:point_shoot_resolve/repository/requests_firestore.dart';
import 'package:point_shoot_resolve/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class FillDetails extends StatefulWidget {
  final File? imageFile;
  const FillDetails({super.key, this.imageFile});

  @override
  State<FillDetails> createState() => _FillDetailsState();
}

class _FillDetailsState extends State<FillDetails> {
  final _formkey = GlobalKey<FormState>();

  String _description = "";
  String _location = "";
  String? _department = "";

  final req = RequestRepository();

   bool isLoading = false;

  Future<void> submitRequest(String? name, String? rollNo, BuildContext context) async {
    if (_formkey.currentState!.validate()) {

      setState(() {
        isLoading = true; // Set loading state to true
      });

      //First upload image to firebase storage
      print("Validation done");
      var storage = FirebaseStorage.instance;
      final File imageLocal = widget.imageFile!;
      String fileName = basename(imageLocal.path);
      // print(fileName);
      TaskSnapshot taskSnapshot =
          await storage.ref("Uploads/$fileName").putFile(imageLocal);
      final String imageURL = await taskSnapshot.ref.getDownloadURL();
      DateTime now = DateTime.now();
      String date = DateFormat.yMd().add_jm().format(now);
      List<String> parts = date.split(' ');
      // Extract date
      String dateString = parts[0];
      // Extract time
      String timeString = parts[1];

      // print('Date: $dateString');
      // print('Time: $timeString');
      final data = {
        "Name": name,
        "Roll No": rollNo,
        "Description": _description,
        "Location": _location,
        "Department": _department,
        "Image URL": imageURL,
        "Date": dateString,
        "Time": timeString,
        "isResolved": false
      };
      await req.createEntry(context, data);
      Navigator.pushReplacementNamed(context, MyRoutes.loggedInStudent);

      setState(() {
        isLoading = false; // Set loading state to true
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.black,
            title: const Text("Submit Request"),
            foregroundColor: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        color: Colors.white,
                        child: widget.imageFile != null
                            ? Image.file(
                                widget.imageFile!,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : SizedBox(height: 200),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white30,
                              width: 1.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Description cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _description = value;
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white30,
                              width: 1.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Location cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _location = value;
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            labelStyle: TextStyle(color: Colors.white),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          iconEnabledColor: Color.fromARGB(255, 255, 255, 255),
                          style: const TextStyle(color: Colors.white),
                          dropdownColor: Colors.black,
                          items: <String>[
                            "Electrical Department",
                            "Plumbing Department",
                            "Hardware Department",
                            "Admin Office"
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
                              _department = value;
                            });
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: isLoading ? null : () async {
                          // form submission here
                          await submitRequest(authProvider.getUser()!.name, authProvider.getUser()!.rollNo, context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          fixedSize: const Size(100, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: isLoading 
                        ? const CircularProgressIndicator() // Loading indicator
                        : const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
