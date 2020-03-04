import 'package:censorapp/screens/home/home.dart';
import 'package:censorapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:censorapp/services/auth.dart';
import 'package:censorapp/shared/constants.dart';
import 'package:flutter/services.dart';




class Census extends StatefulWidget {

  //final Function toggleView;
 // Census ();

  @override
  _CensusState createState() => _CensusState();
}

class _CensusState extends State<Census> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final List<String> genders = ['Male','Female'];
  bool loading = false;

  //text field state
  String firstName = '';
  String lastName = '';
  int age;
  String address ='';
  String gender = '';
  String error = '';
  bool viewer  = false;
 // String _currentGender ;
 // String cpassword = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to CensorApp'),
        actions: <Widget>[

        FlatButton.icon(
        icon: Icon(Icons.person),
        label: Text('logout'),
        onPressed: () async{
          await _auth.signOut();
          // Navigator.push(context,     MaterialPageRoute(builder: (context) => SignIn()));
        }
      ) ,
          FlatButton.icon(
            onPressed: () {
              Navigator.push(context,     MaterialPageRoute(builder: (context) => Home()), );
            },
            icon: Icon(Icons.add_shopping_cart),
            label: Text('View Citizens'),
          ),

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
                      decoration:textInputDecoration.copyWith(hintText: 'First Name'),
                      validator: (val) => val.isEmpty ? 'This field is required' : null,
                      onChanged: (val) {
                        setState(() => firstName = val);
                      }
                  ),


                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration:textInputDecoration.copyWith(hintText: 'Last Name'),
                      validator: (val) => val.isEmpty ? 'This field is required' : null,
                      onChanged: (val) {
                        setState(() => lastName = val);
                      }
                    //Password form field
                  ),

                  SizedBox(height: 20.0),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      decoration:textInputDecoration.copyWith(hintText: 'Enter your age: '),

                     // validator: (val) => val  ? 'Passwords do not match' : null,
                      onChanged: (val) {
                        setState(() => age = int.parse(val));
                      }
                    //Password form field
                  ),


                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration:textInputDecoration.copyWith(hintText: 'Enter your address: '),
                      validator: (val) => val.isEmpty ? 'This field is required' : null,
                      onChanged: (val) {
                        setState(() => address = val);
                      }
                    //Password form field
                  ),

//                  SizedBox(height: 20.0),
//                  DropdownButtonFormField(
//                      decoration:textInputDecoration.copyWith(hintText: 'Gender'),
//                      value: gender ?? 'Male',
//                      items: genders.map((gender){
//                        return DropdownMenuItem(
//                        value: gender,
//                        child: Text('$gender'),
//                        );
//                    }).toList(),
//                      //validator: (val) => val.isEmpty ? 'This field is required' : null,
//                      onChanged: (val) {
//                        setState(() =>this._currentGender = val);
//                      }
//                    //Password form field
//                  ),
//
//


                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration:textInputDecoration.copyWith(hintText: 'Enter your gender: '),
                      validator: (val) => val.isEmpty ? 'This field is required' : null,
                      onChanged: (val) {
                        setState(() => gender = val);
                      }
                    //Password form field
                  ),


                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        //setState(() => loading = true);
                        await _auth.fillOutCensusForm(firstName, lastName, age, gender, address);
                        Navigator.push(context,     MaterialPageRoute(builder: (context) => Home()), );
                        //dynamic result = await _auth.registerWithEmailAndPassword(email,  password);
//                        if(result == null){
//                          setState(() {
//                            error = 'please supply a valid email';
//                            loading = false;
//                          });
//                        }
//                        //print(email);
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


class Viewer extends StatelessWidget {

  Viewer();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
