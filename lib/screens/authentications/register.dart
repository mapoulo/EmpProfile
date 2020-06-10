import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:user_crud/screens/services/auth.dart';
import 'package:user_crud/shared/decotaion.dart';
import 'package:user_crud/shared/loader.dart';


class Register extends StatefulWidget {

  final Function togglePages;

  Register({this.togglePages});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String email;
  String password;
  String error = "";
  bool loader = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
      return loader ? Loader() : Scaffold(

        backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill
              )
            ),

            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 15,
                  height: 190,
                  width: 60,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/light-1.png")
                      )
                    ),
                  ),
                ),

                Positioned(
                  left: 100,
                  height: 120,
                  width: 40,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/light-2.png")
                      )
                    ),
                  ),
                ),

                Positioned(
                  left: 350,
                  height: 190,
                  width: 60,
                  top: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/clock.png")
                      )
                    ),
                  ),
                )
              ],
            ),

          ),

          Padding(
            padding: EdgeInsets.all(40),

            

                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[

                      Container(
                        padding: EdgeInsets.only(left:10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Color.fromARGB(225, 8, 132, 241),
                              offset: Offset(10, 0)
                            )
                          ]
                        ),
                        child: TextFormField(
                          validator: (val) => val.isEmpty ? "Field cannot be empty!" : null,
                          onChanged: (val){
                             setState(() {
                               email = val;
                             });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      
                      Container(
                        padding: EdgeInsets.only(left:10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Color.fromARGB(225, 8, 132, 241),
                              offset: Offset(10, 0)
                            )
                          ] 
                        ),
                        child: TextFormField(
                          obscureText: true,
                          validator: (val) => val.isEmpty ? "Field cannot be empty!" : null,
                          onChanged: (val){
                             setState(() {
                               password = val;
                             });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                          ),
                        ),
                      ),

                      SizedBox(height: 60),

                   
                      FlatButton(
                      onPressed: ()async{
                      if(_formKey.currentState.validate()){

                        setState(() {
                          loader = true;
                        });
                       dynamic result = await AuthSerices().register(email, password);
                setState(() {
                  loader = false;
                });
                       if(result == null){
                         setState(() {
                           error = "Invalid email";
                         });
                       }
                      }
                },
                         child: ClayContainer(

                           color: Colors.grey[300],
                              height: 50,
                              width: 150,
                              borderRadius: 50,
                             child: Center(child: ClayText("Register", emboss: true, size: 40)),

                         )
                         ),


            SizedBox(height: 20),

            
                      GestureDetector(
                        onTap: (){
                            widget.togglePages();
                        },

                        child: Text(
                          "SignIn",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20
                          ),
                        ),
                      )
                    ],
                  ),
                )
              
          )
        ],
      ),

      // body: Container(
      //   child: Align(
      //     alignment: Alignment.center,
      //     child: Container(
      //       color: Colors.grey,
      //       width: 400,
      //       height: 450,

      //   child: Form(
          
      //     key: _formKey,
      //     child: Column(
      //       children: <Widget>[
      //         TextFormField(
                
      //           decoration: decoration.copyWith(hintText: "email"),
      //           validator: (val) => val.isEmpty ? "Please enter email": null,
      //           onChanged: (val){
      //             setState(() {
      //               email = val;
      //             });
      //           },
      //         ),

      //         SizedBox(height: 25),

      //         TextFormField(
      //           decoration: decoration.copyWith(hintText: "Password"),
      //           obscureText: true,
      //           validator: (val) => val.length < 5 ? "Password must be greater that 5" : null,

      //           onChanged: (val){
      //             setState(() {
      //               password = val;
      //             });
      //           },
      //         ),

      //         Text(
      //           error,
      //            style: TextStyle(
      //           color: Colors.red,
      //           fontSize: 15.0
      //         ),
      //         ),

      //         SizedBox(height: 25),

      //         FlatButton(
      //           onPressed: ()async{
      //                 if(_formKey.currentState.validate()){

      //                   setState(() {
      //                     loader = true;
      //                   });
      //                  dynamic result = await AuthSerices().register(email, password);
      //           setState(() {
      //             loader = false;
      //           });
      //                  if(result == null){
      //                    setState(() {
      //                      error = "Invalid email";
      //                    });
      //                  }
      //                 }
      //           },

      //           child: Text(
      //             "Register"
      //           ),

      //           color: Colors.white,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.only(topRight: Radius.circular(20))
      //           ),
      //         ),

      //         SizedBox(height: 20),

      //         GestureDetector(
      //           onTap: (){
      //             widget.togglePages();
      //           },

      //           child: Text(
      //             "Sign In"
      //           ),
      //         )
      //       ],
      //     ),
      //   ),

      //     ),
      //   ),
      // ),
    );
  }
}