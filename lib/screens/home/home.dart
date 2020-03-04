
import 'package:censorapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:censorapp/services/database.dart';

import 'package:censorapp/screens/home/citizen_list.dart';
import 'package:censorapp/models/citizen.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Citizen>>.value(
     value: DatabaseService().citizen,
     child:Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Censor Application"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
//          FlatButton.icon(
//            icon: Icon(Icons.person),
//            label: Text('logout'),
//            onPressed: () async{
//              await _auth.signOut();
//             // Navigator.push(context,     MaterialPageRoute(builder: (context) => SignIn()));
//            },
//                ),
          FlatButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.add_a_photo),
            label: Text('Add Citizen'),
          ),
              ]
            ),
        body: CitizenList(),
    )
    );
  }
}
