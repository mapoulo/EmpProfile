import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/userdata.dart';
import 'package:user_crud/screens/home/Top_part.dart';
import 'package:user_crud/screens/home/bottom_part.dart';
import 'package:user_crud/screens/services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<List<Flowers>>.value(
        initialData: null,
        value: DatabaseServices().flowers_stream,
        builder: (context, _){
          return Scaffold(
          backgroundColor: Color.fromARGB(255, 174, 179, 175),
          body: Column(
            children: <Widget>[
              TopPart(),
              BottomPart()
            ],
          )
        );
        },
    );
   
  }
}
