import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/models/userdata.dart';
import 'package:user_crud/screens/services/database.dart';


class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {

  String name;
  String occupation;
  String jobDescription;
  final _formKey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {

    final  user = Provider.of<User>(context);

     return StreamBuilder(
       stream: DatabaseServices(uid: user.userId).theUserDataStream,
       builder: (context, snapshot){
         
         if(snapshot.hasData){

            UserData data = snapshot.data;
print(data.jobDescription);
           return Scaffold(

             body: Container(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             color: Colors.grey[300],

             child: Column(
               children: <Widget>[

                 SizedBox(height: 60),

CircleAvatar(
  backgroundImage: AssetImage(
    "assets/images/employee.jpg"
  ),

  radius: 150,

),


      SizedBox(height: 50),

 Container(

  margin: EdgeInsets.all(40),

   child:  Form(
        key: _formKey,
        child: Column(

mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            
            Container(
              
              child: TextFormField(
                initialValue: data.name,
                 validator: (val) => val.isEmpty ? "Field cannot be empty" : null,
                 onChanged: (val){
                    setState(() {
                      name = val;
                    });
                 },
              ),
            ),

             Container(
              
              child: TextFormField(
                initialValue: data.occupation,
                validator: (val) => val.isEmpty ? "Field cannot be empty" : null,
                onChanged: (val){
                  setState(() {
                    occupation = val;
                  });
                },
              ),
            ),



 Container(
              
              child: TextFormField(
                initialValue: data.jobDescription,
                validator: (val) => val.isEmpty ? "Field cannot be empty" : null,
                onChanged: (val){
                  setState(() {
                    jobDescription = val;
                  });
                },
              ),
            ),

            SizedBox(height: 50),
         
            Container(
              margin: EdgeInsets.only(top: 30),
              color: Colors.white,
              child: FlatButton(
                onPressed: ()async{
                
                if(_formKey.currentState.validate()){
                   await DatabaseServices(uid: user.userId).theUpdate(name ?? data.name, occupation ?? data.occupation, jobDescription ?? jobDescription);
                   Navigator.pop(context);
                }

                },

                child: Text(
                  "Edit"
                ),
              ),
            )
          ],
        ),
      ),
 )

               ],
             )
           ),
           );
         }else{
           return Text("");
         }
        
       },
     );
  }
}