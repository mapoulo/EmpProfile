import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_crud/models/userdata.dart';

class DatabaseServices{

  @required final String uid;
 

  DatabaseServices({this.uid});

   CollectionReference collection = Firestore.instance.collection("users");

//update data
      Future update(String name, String occupation, String jobDecription)async{
        
        collection.document(uid).setData(
          {
            "name": name,
            "occupation": occupation,
            "jobDescription": jobDecription
          }
        );
      }


      //update data
      Future theUpdate(String name, String occupation, String jobDescription)async{
        
        collection.document(uid).updateData(
          {
            "name": name,
            "occupation": occupation,
            "jobDescription": jobDescription
          }
        );
      }

//user data from snapshot
List<UserData>  _userFromSnapShot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc){
      return UserData(
        name: doc.data['name'] ?? 'name',
        occupation: doc.data['occupation'] ?? 'occupation',
        jobDescription: doc.data['jobDescription'] ?? 'jobDescription'
      );
  }).toList();
}


Stream<List<UserData>>  get userData{
  return collection.snapshots().map(_userFromSnapShot);
}


//get user data
UserData _userDataStream(DocumentSnapshot snapshot){
  return UserData(
    name: snapshot.data['name'],
    occupation: snapshot.data['occupation'],
    jobDescription: snapshot.data['jobDescription']
  );
}


Stream<UserData> get theUserDataStream{
  return collection.document(uid).snapshots().map((_userDataStream));
}

 


    
}