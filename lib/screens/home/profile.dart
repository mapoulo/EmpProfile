import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/models/userdata.dart';

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
      }
    });

    String myImage;

    Future<void> _addPathToDatabase(String text) async {
      try {
        final ref = FirebaseStorage().ref().child(text);
        myImage = await ref.getDownloadURL();

        await Firestore.instance
            .collection("users")
            .document(loggedInUser.userId)
            .updateData({"image": myImage});
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

    _bottomShhet(){
    return showMaterialModalBottomSheet(
  context: context,
  builder: (context, scrollController) => Container(
    height: 400,
    width: MediaQuery.of(context).size.width,
    color: Colors.yellow,
  ),
);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Profile",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(height: 50),
                Center(
                  child: Stack(
                    children: <Widget>[
                      dataIsLoading
                          ? Shimmer.fromColors(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: CircularProgressIndicator(),
                              ),
                              baseColor: Colors.yellow,
                              highlightColor: Colors.blue,
                              period: Duration(seconds: 2),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Image.network(
                                  loggeInUserData.image,
                                  fit: BoxFit.fill,
                                
                                ),
                              ),
                            ),
                      Positioned(
                        top: 70,
                        left: 78,
                        child: GestureDetector(
                          onTap: () {
                            _takeProfilePicture();
                          },
                          child: Icon(
                            Icons.camera_alt,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: dataIsLoading
                      ? Shimmer.fromColors(
                          child: Text(
                            ". . .",
                            style: TextStyle(fontSize: 15),
                          ),
                          baseColor: Colors.yellow,
                          highlightColor: Colors.blue)
                      : Stack(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  loggeInUserData.name,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 0.0,
                                left: 210,
                                child: GestureDetector(
                                  onTap: () {
                                    _bottomShhet();
                                  },
                                  child: Icon(Icons.edit, color: Colors.grey),
                                ))
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
