import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findagig/models/Gig.dart';
import 'package:findagig/models/Users.dart';
import 'package:findagig/shared/types_of_gig.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference coll_users = Firestore.instance.collection('users');
  final CollectionReference coll_gigs = Firestore.instance.collection('gigs');

  Future updateUserData (String uid, String email, String name, String password) async {
    print("UPDATING");
    return await coll_users.document(uid).setData({
      'uid': uid,
      'name' : name,
      'password' : password,
      'email' : email,
      'image' : 'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'
    });
  }

  Future insertGigData () async {
    print("--------------- UPDATING GIG ---------------");
    return await coll_gigs.document().setData({
      'city' : 'city',
      'contact': 913123123,
      'description' : "Empty",
      'employer' : "Andrade",
      'local': new GeoPoint(0, 0),
      'name' : 'name',
      'reward': 0,
      'taken': false,
      'type' : 'tipo.toString()',
    });
  }

  Future editUserData(String uid, String email, String name, String password) async {
    print("--------------- UPDATING GIG ---------------");
    return await coll_gigs.document(uid).setData({
      'email' : email,
      'name' : name,
      'password' : password,
    });
  }

  // Gig list from snapshot
  List<Users> _list_users(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Users(
        name: doc.data['name'] ?? '',
        city: doc.data['city'] ?? '',
        type: doc.data['type'] ?? '',
      );
    }).toList();
  }

  // get gigs
  Stream<List<Users>> get users {
    return coll_users.snapshots().map(_list_users);
  }

  // Gig list from snapshot
  List<Gig> _list_gigs(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Gig(
        city: doc.data['city'] ?? '',
        name: doc.data['name'] ?? '',
        type: doc.data['type'] ?? '',
        coords: doc.data['local'] ?? '',
      );
    }).toList();
  }

  // get gigs
  Stream<List<Gig>> get gigs {
    return coll_gigs.snapshots().map(_list_gigs);
  }

}