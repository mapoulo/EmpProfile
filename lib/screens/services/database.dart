import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_crud/models/userdata.dart';

class DatabaseServices {
  @required
  final String uid;

  DatabaseServices({this.uid});

  CollectionReference collection = Firestore.instance.collection("users");
  CollectionReference flowers_collection =
      Firestore.instance.collection("flowers");

  Future update(
      String uid, String name, String image) async {
    collection.document(uid).setData({
      "uid": uid,
      "name": name,
      "image": image
    });
  }


  List<Flowers> _floweFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Flowers(
          flowerName: doc.data['rose'] ?? 'rose',
        );
    }).toList();
  }

  Stream<List<Flowers>> get flowers_stream {
    return flowers_collection.snapshots().map(_floweFromSnapShot);
  }



  List<UserData> _userFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
          uid: doc.data['uid'] ?? 'uid',
          name: doc.data['name'] ?? 'name',
          image: doc.data['image'] ?? "",
        );
    }).toList();
  }

  Stream<List<UserData>> get userData {
    return collection.snapshots().map(_userFromSnapShot);
  }

  UserData _userDataStream(DocumentSnapshot snapshot) {
    return UserData(
        name: snapshot.data['name'],
        image: snapshot.data['image'],
      );
  }

  Stream<UserData> get theUserDataStream {
    return collection.document(uid).snapshots().map((_userDataStream));
  }
}

final dataseServices = DatabaseServices();