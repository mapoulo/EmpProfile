import 'package:flutter/material.dart';
import 'package:user_crud/screens/authentications/login.dart';
import 'package:user_crud/screens/authentications/register.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

    bool showLogin = true;

  void togglePages(){
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if(showLogin){ 
        return Login(togglePages: togglePages);

    }else{
    return Register(togglePages: togglePages);
    }

  }
}