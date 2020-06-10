import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/userdata.dart';
import 'package:user_crud/screens/home/details.dart';


class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<List<UserData>>(context) ?? [];
       userData.forEach((element) { 
         print("data here is "+element.name);
       });

    return Container(
      height: 300,
      child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: userData.length,
      itemBuilder: (context, int index){
        UserData obj = userData[index];
        return Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Details(image: "assets/images/employee.jpg", obj: obj)
                    ));
              },

              child: Container(
                height: 300,
                width: 250,
                margin: EdgeInsets.all(5),
                child: Hero(
                tag: 'tag'+index.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    width: 250,
                    image: AssetImage("assets/images/employee.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              )
            ),
            
            Positioned(
              top: 250,
              left: 10,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  obj.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    
                  ),
                ),
              )
            )
          ],
        );
      }),
    );
  }
}