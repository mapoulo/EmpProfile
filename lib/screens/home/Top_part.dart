import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/models/userdata.dart';
import 'package:user_crud/screens/home/bottom_part.dart';

class TopPart extends StatefulWidget {
  @override
  _TopPartState createState() => _TopPartState();
}

class _TopPartState extends State<TopPart> {
  UserData loggeInUserData;
  bool dataIsLoading = true;

  @override
  Widget build(BuildContext context) {
    final listOfUserFromFirebase = Provider.of<List<UserData>>(context) ?? [];
    final loggedInUserUid = Provider.of<User>(context);

    listOfUserFromFirebase.forEach((element) {
      if (element.uid == loggedInUserUid.userId) {
        loggeInUserData = element;
        dataIsLoading = false;
        print(element.name);
      }
    });

    return StreamProvider.value(
      initialData: null,
      value: null,
      builder: (context, snapshot) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Container(
            height: 260,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 225, 225, 231),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.menu),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                    )
                  ],
                ),
                Container(
                    child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.grey[500], fontSize: 20),
                      text: "Hi,  ",
                      children: [
                        TextSpan(
                          text: dataIsLoading ? "" : loggeInUserData.name,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ]),
                )),
                SizedBox(height: 25),
                Center(
                  child: Container(
                    height: 40,
                    width: 280,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 79,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 65,
                          width: 57,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                        );
                      }),
                )
              ],
            ),
          ),

       
            ],
          )
        );
      },
    );
  }
}
