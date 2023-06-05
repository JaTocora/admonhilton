import 'package:admonhilton/models/class_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportsProvider =
    StreamProvider.family<List<Clsdata>, bool>((ref, valor) {
  final collection = FirebaseFirestore.instance
      .collection('report')
      .where('dateupd', isNull: valor);
  return collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      if (valor) {
        return Clsdata(
          docId: doc.id,
          report: doc['report'],
          datereg: doc['datereg'],
          uidphotoreport: doc['uidphotoreport'],
          dateupd: doc['dateupd'],
          location: doc['location'],
          uidemployeeadd: doc['uidemployeeadd'],
        );
      } else {
        return Clsdata(
          docId: doc.id,
          datereg: doc['datereg'],
          location: doc['location'],
          report: doc['report'],
          uidemployeeadd: doc['uidemployeeadd'],
          uidphotoreport: doc['uidphotoreport'],
          dateupd: doc['dateupd'],
          reportfix: doc['reportfix'],
          uidphotofix: doc['uidphotofix'],
          uidemployeeupd: doc['uidemployeeupd'],
        );
      }

      // return Dataresume(
      //   id: doc.id,
      //   location: doc['location'],
      //   report: doc['report'],
      //   userreport: doc['uidemployeeadd'],
      //   datereg: doc['datereg'],
      //   dateupd: doc['dateupd'],
      // );
    }).toList();
  });
});

final locationProvider =
    StreamProvider.family<String, String>((ref, id) async* {
  final collection = FirebaseFirestore.instance.collection('locations');
  yield* collection.doc(id).snapshots().map((snapshot) {
    return snapshot.get('location') as String;
  });
});

final userProvider = StreamProvider.family<String, String>((ref, id) async* {
  final collection = FirebaseFirestore.instance.collection('users');
  yield* collection.doc(id).snapshots().map((snapshot) {
    String nameuser = '${snapshot['first_name']} ${snapshot['last_name']}';
    // return snapshot.get('first_name') as String;
    return nameuser;
  });
});

final imageProvider =
    FutureProvider.family<String, String>((ref, idimage) async {
  // Obtiene una referencia al archivo de imagen en Firebase Storage
  try {
    final collection = await FirebaseStorage.instance
        .ref('pictures_room')
        .child(idimage)
        .getDownloadURL();
    return collection;
  } catch (e) {
    return e.toString();
  }
});

final datalistProvider = StateProvider<bool>((ref) {
  return true;
});

final detailProvider =
    StreamProvider.family<List<Dataresume>, bool>((ref, valor) {
  final collection = FirebaseFirestore.instance
      .collection('report')
      .where('dateupd', isNull: valor);
  return collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return Dataresume(
        id: doc['id'],
        location: doc['location'],
        report: doc['report'],
        userreport: doc['uidemployeeadd'],
        datereg: doc['datereg'],
        dateupd: doc['dateupd'],
      );

      // return Clsdata(
      //   docId: doc.id,
      //   datereg: doc['datereg'],
      //   location: doc['location'],
      //   report: doc['report'],
      //   uidemployeeadd: doc['uidemployeeadd'],
      //   uidphotoreport: doc['uidphotoreport'],
      //   dateupd: doc['dateupd'] ?? ,
      //   reportfix: doc['reportfix'] ?? '',
      //   uidphotofix: doc['uidphotofix'] ?? '',
      // );
    }).toList();
  });
});
