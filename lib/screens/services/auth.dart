import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/screens/services/database.dart';


class AuthSerices{


  FirebaseAuth _auth = FirebaseAuth.instance;


  User _userFromFirebase(FirebaseUser user){
    return user.uid == null ? null : User(userId: user.uid);
  }


  Stream<User>  get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebase(user));
  }


  Future login(String email, String password)async{

     try{
      AuthResult results = await  _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user  = results.user;
      return _userFromFirebase(user);
   }catch(e){
      print(e.toString());
      return null;
   }

  }


  Future register(String email, String password)async{
    try{

        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        FirebaseUser user = result.user;

       await DatabaseServices(uid: user.uid).update("Name", "Occupation", "N/A");

        return _userFromFirebase(user);

    }catch(e){
      print(e.toString());
    }
  }

  Future logOut()async{
    try{
      await  _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }


}