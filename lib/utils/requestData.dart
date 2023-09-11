import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RequestData {
  final String? id;
  final String name;
  final String rollNo;
  final String date;
  final String description;
  final String imageURL;
  final String location;
  final String time;
  final bool isResolved;
  final String department;

  const RequestData(
      {this.id,
      required this.name,
      required this.rollNo,
      required this.date,
      required this.description,
      required this.imageURL,
      required this.location,
      required this.time,
      required this.isResolved,
      required this.department
    });

  factory RequestData.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
      final data = document.data()!;
      return RequestData(
        id: document.id,
        name: data["Name"],
        rollNo: data["Roll No"],
        date: data["Date"],
        description: data["Description"],
        imageURL: data["Image URL"],
        location: data["Location"],
        time: data["Time"],
        isResolved: data["isResolved"],
        department: data["Department"]
      );
  }
}
