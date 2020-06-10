import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/screens/services/auth.dart';
import 'package:user_crud/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
   
   return StreamProvider.value(
     value: AuthSerices().user,
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       home: Wrapper(),
     ),
     );
  }
}