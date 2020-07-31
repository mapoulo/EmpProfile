import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/screens/authentications/authentication.dart';
import 'package:user_crud/screens/home/custom_drawer.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    if(user == null){
      return Authentication();
    }else{
      return CustomDrawer();
    }
  }
}