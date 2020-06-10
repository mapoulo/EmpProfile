import 'package:flutter/material.dart';
import 'package:user_crud/models/officePictures.dart';


class TheImages extends StatefulWidget {

  final OfficePictures obj;
  TheImages({this.obj});

  @override
  _TheImagesState createState() => _TheImagesState(obj: obj);
}

class _TheImagesState extends State<TheImages> {

  OfficePictures obj;
_TheImagesState({this.obj});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
         

          Stack(
            children: <Widget>[

               Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Hero(
                          tag: "pic",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                              image: AssetImage(obj.imageUrl),
                              fit: BoxFit.cover,
                              ),
                          ),
                        ),
          ),

              Positioned(
                top: 30,
                left: 15,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },

                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
              )
            ],
          ),

          SizedBox(height: 60),
          
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  obj.description,
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