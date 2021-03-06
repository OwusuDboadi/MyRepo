import 'package:censorapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:censorapp/services/auth.dart';
import 'package:censorapp/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String cpassword = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to CensorApp'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          },
              icon: Icon(Icons.person),
              label: Text('Sign Up'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
           child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
               child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                    decoration:textInputDecoration.copyWith(hintText: 'E-mail'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                ),


                SizedBox(height: 20.0),
                TextFormField(
                    decoration:textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length <6 ? 'Password should be more than 6 chars' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
                  //Password form field
                ),

                SizedBox(height: 20.0),
                TextFormField(
                    decoration:textInputDecoration.copyWith(hintText: 'Confirm Password'),
                    obscureText: true,
                    validator: (val) => val!=password ? 'Passwords do not match' : null,
                    onChanged: (val) {
                      setState(() => cpassword = val);
                    }
                  //Password form field
                ),

                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);

                      dynamic result = await _auth.registerWithEmailAndPassword(email,  password);
                      if(result == null){
                        setState(() {
                           error = 'please supply a valid email';
                           loading = false;
                        });
                      }
                      //print(email);
                      //print(password);

                    }
                  },
                ),
            SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )

              ],
            )
           ),
        ),
      ),
    );
  }
}
