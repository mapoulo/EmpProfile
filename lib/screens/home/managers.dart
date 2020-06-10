import 'package:flutter/material.dart';
import 'package:user_crud/models/officePictures.dart';
import 'package:user_crud/screens/home/managers_profile.dart';

class Managers extends StatefulWidget {
  @override
  _ManagersState createState() => _ManagersState();
}

class _ManagersState extends State<Managers> {

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[300],
      body: SafeArea(
              child: Column(
          children: <Widget>[

              Container(
                height: 50,
                child: Center(
                  child: Text(
                    "Managers",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30
                    ),
                  ),
                ),
              ),


              Expanded(

                child: Container(

                  
                  padding: EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                  ),

                  child: ListView.builder(
                    itemCount: managers.length,
                    itemBuilder: (context, int index){

                      ManagersList   managersList = managers[index];
                     
                     return Stack(
                        children: <Widget>[

                         GestureDetector(

                           onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ManagerProfile(obj: managersList)
                              ));
                           },
                            child: Container(
                             height: 250,
                             margin: EdgeInsets.all(5),
                             width: MediaQuery.of(context).size.width,
                            child: Hero(
                             tag: 'tag'+ index.toString(),
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                               child: Image(
                                 height: 250,
                                 image: AssetImage(managersList.imageUrl),
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),
                           ),
                         ),

                         

                         Positioned(
                           top: 200,
                           left: 10,
                           child: Text(
                             managersList.name,
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 20
                             ),
                           ),
                         ),

                         
                         Positioned(
                           top: 200,
                           left: 280,
                           child: FlatButton(
                             onPressed: (){
                               Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ManagerProfile(obj: managersList)
                              ));
                             },
                             child: Text(
                               "View",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                               ),
                             ),
                              color: Colors.grey,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
                             )
                           )
                         ),

                          
                        ],
                     );
                    }
                    )
                ),
              )
            
          ],
        ),
      )
    );
  }
}