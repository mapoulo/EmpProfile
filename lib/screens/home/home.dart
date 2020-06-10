import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/officePictures.dart';
import 'package:user_crud/models/userdata.dart';
import 'package:user_crud/screens/authentications/login.dart';
import 'package:user_crud/screens/home/edit_profile.dart';
import 'package:user_crud/screens/home/images.dart';
import 'package:user_crud/screens/home/list.dart';
import 'package:user_crud/screens/home/managers.dart';
import 'package:user_crud/screens/services/auth.dart';
import 'package:user_crud/screens/services/database.dart';
import 'package:clay_containers/clay_containers.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool loader = false;
 
  @override
  Widget build(BuildContext context) {
    
    return StreamProvider<List<UserData>>.value(
      value: DatabaseServices().userData,
      child: Scaffold(

        
        drawer: Drawer(
          
  child: Container(
    color: Colors.grey[300],

    child: Column(
      children: <Widget>[

        SizedBox(height: 50),

        CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage(
            "assets/images/employee.jpg"
          ),
        ),

        SizedBox(height: 50),

        GestureDetector(
          
          onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return Edit();
                  }
              ));
          },

          child: ClayContainer(
            
            borderRadius: 10,
            height: 50,
            width: 250,
            color: Colors.grey[300],

            child: Center(child: ClayText("Edit profile", emboss: true, size: 30)),
          ),
         

        ),

        
        SizedBox(height: 35),
        
        GestureDetector(
           onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => Managers()
                     ));
                  },

          
          child: ClayContainer(
            
            borderRadius: 10,
            height: 50,
            width: 250,
            color: Colors.grey[300],

            child: Center(child: ClayText("Managers", emboss: true, size: 30)),
          ),
        ),


             SizedBox(height: 35),
    
        
        GestureDetector(
           onTap: ()async{
                      await AuthSerices().logOut();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                  },

          
          child: ClayContainer(
            
            borderRadius: 10,
            height: 50,
            width: 250,
            color: Colors.grey[300],

            child: Center(child: ClayText("Sign Out", emboss: true, size: 30)),
          ),
        )
      ],
    ),
  )
),
            backgroundColor: Colors.grey[300],
          appBar: AppBar(

            
            backgroundColor: Colors.grey[300],
            title: Text(
              "Employees",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25
              ),
            ),

            centerTitle: true,

           
           
          ),

          body: Column(
            children: <Widget>[

              UserList(),

              Container(
                margin: EdgeInsets.all(10),
                height: 30,
                
                child: Center(
                  child: Text(
                    "Company's Images",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, int index){
                    OfficePictures  pictures = images[index];
                    return Column(

                      children: <Widget>[
                        Container(
                          
                        child: Stack(
                          children: <Widget>[

                            GestureDetector(

                              onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TheImages(obj: pictures)
                                  ));
                              },

                              child:  Container(
                                height: 220,
                          margin: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                        
                        child: Hero(
                          tag: "pic"+index.toString(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: AssetImage(pictures.imageUrl),
                              fit: BoxFit.cover,
                              ),
                          ),
                        ),
                        ),
                            ),

                             


                        Positioned(
                          top: 170,
                          left: 310,
                          
                          
                            child: FlatButton(
                              onPressed: (){
                                     Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TheImages(obj: pictures)
                                  ));
                              },
                                color: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
                                ),
                              child: Text(
                              "View",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                            )
                          
                        ),
                          ],
                        ),
                        
                        )
                      ],
                    );
                  }
                  )
                )

            ],
          ),
        ),
      );
  }
}