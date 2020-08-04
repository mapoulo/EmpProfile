import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/models/userdata.dart';
import 'package:user_crud/screens/authentications/login.dart';
import 'package:user_crud/screens/home/home.dart';
import 'package:user_crud/screens/home/profile.dart';
import 'package:user_crud/screens/services/auth.dart';
import 'package:user_crud/screens/services/database.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    super.initState();
  }

  void toggleAnimation() {
    if (controller.isDismissed) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

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

    var myDrawer = Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 174, 179, 175),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 28),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(height: 20),
            Container(
              width: 170,
              height: 60,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text:dataIsLoading ? "" : loggeInUserData.name,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  TextSpan(
                    text: "\n",
                  ),
                  TextSpan(
                    text: "Active ",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Profile(),
                ));
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text(
                      "Profile",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Text(
                    "Profile",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Text(
                    "Profile",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(height: 80),
            GestureDetector(
              onTap: () async {
                await myAuth.logOut();
                Login();
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Text(
                      "Log Out",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    var childContainer = Home();

    return StreamProvider<List<Flowers>>.value(
        initialData: null,
        value: DatabaseServices().flowers_stream,
        builder: (context, snapshot) {
          return Scaffold(
            body: GestureDetector(
                onTap: () {
                  toggleAnimation();
                },
                onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
                  if (dragEndDetails.primaryVelocity > 0.0) {
                    toggleAnimation();
                  } else if (dragEndDetails.primaryVelocity < 0.0) {
                    toggleAnimation();
                  }
                },
                child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      double slide = maxSlide * controller.value;
                      double scale = 1 - controller.value * 0.3;
                      return Stack(
                        children: <Widget>[
                          myDrawer,
                          Transform(
                            transform: Matrix4.identity()
                              ..translate(slide)
                              ..scale(scale),
                            child: childContainer,
                            alignment: Alignment.centerRight,
                          )
                        ],
                      );
                    })),
          );
        });
  }
}
