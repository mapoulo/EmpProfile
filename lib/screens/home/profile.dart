
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {

File _image;


 Future<void>  _addPathToDatabase(String text)async{
    try{
     final ref = FirebaseStorage().ref().child(text);
     var imageString = await ref.getDownloadURL();

     //Add location and url to database
     await Firestore.instance.collection("storage").document().setData({"url": imageString});
    }catch(e){

    }
  }
  

Future<void> uploadImage(File image)async{
    try{
     int randomNumber = Random().nextInt(100000);
     String imageLocation = "images/image$randomNumber.jpg";

     //upload image to firebase
     final StorageReference storageReference = FirebaseStorage().ref().child(imageLocation);
     final StorageUploadTask uploadTask = storageReference.putFile(image);
     await uploadTask.onComplete;
     _addPathToDatabase(imageLocation);
    }catch(e){

    }
  }


 


  Future _takeProfilePicture() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 60.0, maxWidth: 60);
    uploadImage(image);
  }

  

  // Future _selectProfilePicture() async{
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState((){
  //     _image = image;
  //   });
  // }

  

 

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
        ),

        
      ),

      body: GestureDetector(
        onTap: (){
_takeProfilePicture();
        },

        child: Container(
          height: 150,
          width: 150,
          color: Colors.yellow
        ),
      ),
    );
  }
}
