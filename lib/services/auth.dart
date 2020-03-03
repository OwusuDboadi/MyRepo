import 'package:censorapp/models/user.dart';
import 'package:censorapp/screens/home/home.dart';
import 'package:censorapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }


  Stream<User> get user{

    return _auth.onAuthStateChanged
     // .map((FirebaseUser user) => _userFromFirebaseUser(user) );
    .map(_userFromFirebaseUser);
  }

  //Sign in anonymously
  Future signInAnon() async {
    try{
     AuthResult result = await _auth.signInAnonymously();
     FirebaseUser user = result.user;
     return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future fillOutCensusForm(String firstName, String lastName, int age, String gender, String address) async {
    try{
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      await DatabaseService().updateUserData(firstName, lastName, age, gender, address);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future printOutCensusInformation(String user_id) async{
    try{

    }catch(e){

    }
  }


  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}