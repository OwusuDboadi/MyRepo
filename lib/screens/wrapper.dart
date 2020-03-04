import 'package:censorapp/screens/authenticate/authenticate.dart';
import 'package:censorapp/screens/home/census.dart';
//import 'package:censorapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:censorapp/models/user.dart';


class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return either home or authenticate widget
    if(user == null){
      return Authenticate();
    }
    else{
      return Census();
    }
  }
}
