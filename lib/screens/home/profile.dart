import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/models/userdata.dart';
import 'package:user_crud/screens/services/database.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double maxSlide = 120.0;
  var loggeInUserData;
  bool dataIsLoading = true;

  @override
  Widget build(BuildContext context) {
    final listOfUserFromFirebase = Provider.of<List<UserData>>(context) ?? [];
    final loggedInUser = Provider.of<User>(context);

    listOfUserFromFirebase.forEach((element) {
      if (element.uid == loggedInUser.userId) {
        loggeInUserData = element;
        dataIsLoading = false;
        print(element.name);
      }
    });
   
    String myImage;

    Future<void> _addPathToDatabase(String text) async {
      try {
        final ref = FirebaseStorage().ref().child(text);
       myImage  = await ref.getDownloadURL();
await DatabaseServices(uid: loggeInUserData.uid).update(loggeInUserData.uid, loggeInUserData.name, myImage, loggeInUserData.occupation, loggeInUserData.jobDecription);
        //Add location and url to database
        await Firestore.instance
            .collection("storage")
            .document()
            .setData({"url": myImage});
      } catch (e) {}
    }

    Future<void> uploadImage(File image) async {
      try {
        int randomNumber = Random().nextInt(100000);
        String imageLocation = "images/image$randomNumber.jpg";

        //upload image to firebase
        final StorageReference storageReference =
            FirebaseStorage().ref().child(imageLocation);
        final StorageUploadTask uploadTask = storageReference.putFile(image);
        await uploadTask.onComplete;
        _addPathToDatabase(imageLocation);
      } catch (e) {}
    }

    Future _takeProfilePicture() async {
      var image = await ImagePicker.pickImage(
          source: ImageSource.camera, maxHeight: 60.0, maxWidth: 60);
      uploadImage(image);
     
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10, width: 5),
              Container(
                  child: Row(
                children: <Widget>[Text("Profile")],
              )),
              SizedBox(height: 25),
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50)),
                      child: dataIsLoading
                          ? Icon(Icons.person)
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(loggeInUserData.image, fit: BoxFit.cover,),
                          ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _takeProfilePicture();
                    },
                                      child: Positioned(
                      top: 70,
                      left: 185,
                      child: Icon(Icons.camera_alt, color: Colors.grey),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Center(child: Text(dataIsLoading ? "" : loggeInUserData.name)),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Selected Items"),
                  Text("View More"),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                  child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        color: Colors.black,
                        width: 150,
                        height: MediaQuery.of(context).size.height,
                      );
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
