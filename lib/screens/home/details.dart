import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/models/userdata.dart';


class Details extends StatefulWidget {

     final String image;
     final UserData obj;

    String _newName;
    String _newOccupation;


    Details({this.image, this.obj});

  @override
  _DetailsState createState() => _DetailsState(image: image, obj: obj);

}

class _DetailsState extends State<Details> {

  String image;
final UserData obj;


  _DetailsState({this.image, this.obj});


  @override

 
  
  Widget build(BuildContext context) {


final userId = Provider.of<User>(context);
   
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: Column(
          children: <Widget>[

            Stack(
              children: <Widget>[

                  Container(
              height: 400,
              width: double.infinity,
              
              child: Hero(
        tag: 'tag',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        )
      ),
            ),

          

            Positioned(
              top: 30,
              left: 10,
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(Icons.arrow_back, color: Colors.grey),
                ),
              ),
            )

              ],
    ),

    SizedBox(height: 20),

    Padding(
      padding: EdgeInsets.all(40),

      child: Column(
        children: <Widget>[
          Container(
        child: Text(
        obj.name,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 25
        ),
        ),
      ),

      Container(
        child: Text(
          obj.occupation,
           style: TextStyle(
          color: Colors.grey,
          fontSize: 25
        ),
        ),
      ),


     
        ],
      )

      
    ),

    Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Text(
            obj.jobDescription,
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
      ),
    );
  }
}