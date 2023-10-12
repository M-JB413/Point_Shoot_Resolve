import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/request_data.dart';

class RequestRepository {
  final _fireStore = FirebaseFirestore.instance;

  // createEntry(Map<String, String?> entry) async {
  //   _fireStore
  //       .collection("Requests")
  //       .add(entry)
  //       .whenComplete(() => print("Success") //Insert simple snackbar
  //           )
  //       .catchError((error, StackTrace) {
  //     print(error.toString());
  //   });
  // }
  Future<void> createEntry(
      BuildContext context, Map<String, Object?> entry) async {
    try {
      await _fireStore.collection("Requests").add(entry);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Entry created successfully',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
    } catch (error) {
      // print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error creating entry',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
    }
  }

  Future<List<RequestData>> getUserRequests(String rollNo) async {
    final snapshot = await _fireStore
        .collection("Requests")
        .where("Roll No", isEqualTo: rollNo)
        .get();
    final userRequests = snapshot.docs
        .map((e) => RequestData.fromSnapshot(e))
        .toList(); //single value or toList

    return userRequests;
  }

  Future<List<RequestData>> getDepartmentRequests(String department) async {
    final snapshot = await _fireStore
        .collection("Requests")
        .where("Department", isEqualTo: department)
        .get();
    final userRequests = snapshot.docs
        .map((e) => RequestData.fromSnapshot(e))
        .toList(); //single value or toList

    return userRequests;
  }

  Future<List<RequestData>> getDepartmentRequestsResolved(
      String department) async {
    final snapshot = await _fireStore
        .collection("Requests")
        .where("Department", isEqualTo: department)
        .where("isResolved", isEqualTo: true)
        .get();
    final userRequests = snapshot.docs
        .map((e) => RequestData.fromSnapshot(e))
        .toList(); //single value or toList

    return userRequests;
  }

  Future<List<RequestData>> getDepartmentRequestsPending(
      String department) async {
    final snapshot = await _fireStore
        .collection("Requests")
        .where("Department", isEqualTo: department)
        .where("isResolved", isEqualTo: false)
        .get();
    final userRequests = snapshot.docs
        .map((e) => RequestData.fromSnapshot(e))
        .toList(); //single value or toList

    return userRequests;
  }

  Future<List<RequestData>> getAllRequests() async {
    final snapshot = await _fireStore.collection("Requests").get();
    final userRequests = snapshot.docs
        .map((e) => RequestData.fromSnapshot(e))
        .toList(); //single value or toList

    return userRequests;
  }

  Future<List<RequestData>> getAllRequestsResolved() async {
    final snapshot = await _fireStore
        .collection("Requests")
        .where("isResolved", isEqualTo: true)
        .get();
    final userRequests = snapshot.docs
        .map((e) => RequestData.fromSnapshot(e))
        .toList(); //single value or toList

    return userRequests;
  }

  Future<List<RequestData>> getAllRequestsPending() async {
    final snapshot = await _fireStore
        .collection("Requests")
        .where("isResolved", isEqualTo: false)
        .get();
    final userRequests = snapshot.docs
        .map((e) => RequestData.fromSnapshot(e))
        .toList(); //single value or toList

    return userRequests;
  }

  Future<void> resolveComplaint(RequestData data) async {
      await _fireStore
          .collection("Requests")
          .doc(data.id)
          .update(data.updateComplaint());

    // final userRequest =
    //     await _fireStore.collection("Requests").doc(data.id).get();

    // return userRequest;
  }
}
