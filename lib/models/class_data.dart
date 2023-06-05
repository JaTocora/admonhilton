import 'package:cloud_firestore/cloud_firestore.dart';

class Clsdata {
  String? location;
  String? report;
  String? reportfix;
  String? uidemployeeadd;
  String? uidemployeeupd;
  Timestamp datereg;
  Timestamp? dateupd;
  String? docId;
  String? uidphotoreport;
  String? uidphotofix;
  // String? uidusersession;

  Clsdata({
    required this.docId,
    required this.location,
    required this.report,
    required this.datereg,
    this.uidphotoreport,
    this.reportfix,
    this.uidemployeeadd,
    this.dateupd,
    this.uidemployeeupd,
    this.uidphotofix,
    // this.uidusersession
  });

  // Clsdata.empty();

  Map<String, dynamic> toMap() {
    return docId == null
        ? {
            'location': location,
            'report': report,
            'datereg': datereg,
            'uidemployeeadd': uidemployeeadd,
            'uidphotoreport': uidphotoreport,
            'reportfix': reportfix,
            'uidemployeeupd': uidemployeeupd,
            'dateupd': dateupd,
            'uidphotofix': uidphotofix,
            //'uidusersession': uidusersession
          }
        : {
            'docId': docId,
            'location': location,
            'report': report,
            'reportfix': reportfix,
            'uidemployeeadd': uidemployeeadd,
            'uidemployeeupd': uidemployeeupd,
            'datereg': datereg,
            'dateupd': dateupd,
            'uidphotoreport': uidphotoreport,
            'uidphotofix': uidphotofix,
            //'uidusersession': uidusersession
          };
  }
}

class ClsdataProfile {
  String? uidprofile;
  String? email;
  String? firstname;
  String? lastname;
  String? phone;
  bool? newuser = false;

  ClsdataProfile(
      {this.uidprofile,
      this.firstname,
      this.lastname,
      this.phone,
      this.newuser});

  ClsdataProfile.empty();

  Map<String, dynamic> toMap() {
    return uidprofile == null
        ? {
            'firstname': firstname,
            'lastname': lastname,
            'phone': phone,
            'newuser': newuser
          }
        : {
            'uidprofile': uidprofile,
            'firstname': firstname,
            'lastname': lastname,
            'phone': phone,
            'newuser': newuser
          };
  }
}

class Users {
  Users({
    required String id,
    String? email,
  });

  Users.fromJson(Map<String, dynamic> json);
}

class Dataresume {
  String id;
  String location;
  String report;
  String userreport;
  Timestamp datereg;
  Timestamp? dateupd;

  Dataresume(
      {required this.id,
      required this.location,
      required this.report,
      required this.userreport,
      required this.datereg,
      this.dateupd});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      'report': report,
      'userreport': userreport,
      'datereg': datereg,
      'dateupd': dateupd
    };
  }
}
