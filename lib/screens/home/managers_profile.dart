import 'package:flutter/material.dart';
import 'package:user_crud/models/officePictures.dart';

class ManagerProfile extends StatefulWidget {


   final ManagersList obj;
   ManagerProfile({this.obj});


  @override
  _ManagerProfileState createState() => _ManagerProfileState(obj: obj);
}

class _ManagerProfileState extends State<ManagerProfile> {

     final ManagersList obj;
     _ManagerProfileState({this.obj});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: "tag",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    image: AssetImage(obj.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 10,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  
                  },

                  child:  Icon(Icons.arrow_back, size: 30, color: Colors.grey),
                )
              )
            ],
          ),

         SizedBox(height: 30),
         Center(
           child: Text(
             obj.name,
             style: TextStyle(
               color: Colors.grey,
               fontSize: 35
             ),
           ),
         ),

          SizedBox(height: 10),

          Expanded(

            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  obj.duties,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20
                  ),
                ),
              ),
            ),
          )
      
          
        ],
      ),
    );
  }
}