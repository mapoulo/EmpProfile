import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/models/userdata.dart';
import 'package:user_crud/screens/authentications/authentication.dart';
import 'package:user_crud/screens/home/custom_drawer.dart';
import 'package:user_crud/screens/home/profile.dart';
import 'package:user_crud/screens/services/database.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      initialData: null,
      value: DatabaseServices().userData,
      builder: (context, snapshot) {
        final user = Provider.of<User>(context);
        if (user == null) {
          return Authentication();
        } else {
          // return CustomDrawer();
          return Profile();
        }
      },
    );
  }
}
