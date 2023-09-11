class UserDetails {
  final String? name;
  final String? rollNo;
  final String? emailID;
  final String? designation;

  UserDetails({
    required this.name,
    required this.rollNo,
    required this.emailID,
    required this.designation,
  });

  UserDetails getUser() {
    return UserDetails(
        name: name, rollNo: rollNo, emailID: emailID, designation: designation);
  }
}
