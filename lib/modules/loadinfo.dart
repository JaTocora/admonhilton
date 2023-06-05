import 'package:cloud_firestore/cloud_firestore.dart';

// FutureBuilder<String> getUser(String documentId) {
Future<String> getUser(String documentId) async {
  String name = await FirebaseFirestore.instance
      .collection('users')
      .doc(documentId)
      .get()
      .then((value) {
    return '${value['first_name']} ${value['last_name']}';
  });
  return name;
}

Future<String> loadlocation(String locationId) async {
  String location = await FirebaseFirestore.instance
      .collection('locations')
      .doc(locationId)
      .get()
      .then((value) {
    return '${value['location']}';
  });
  return location;
}
