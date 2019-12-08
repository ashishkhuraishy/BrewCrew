import 'package:brewcrew/Shared/constants.dart';
import 'package:brewcrew/Shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/Services/auth_service.dart';

class Register extends StatefulWidget {
  final Function toggle;
  Register({this.toggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  
    //Text Field Values
    String email = '';
    String password = '';

    //helper variables
    String error = '';
    bool loading = false; 
  
    @override
    Widget build(BuildContext context) {
      return loading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          actions: <Widget>[
          FlatButton.icon(
            label: Text("Sign In", style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.person, color: Colors.white,),
            onPressed: (){
              widget.toggle();
            },
          )
        ],
        backgroundColor: Colors.brown[900],
        ),
        body: Container(
          color: Colors.brown[100],
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: "Email"
                  ),
                  validator: (val) => val.isEmpty ? "Enter a valid Email" : null,
                  onChanged: (val){
                    email = val;
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: "Password"
                  ),
                  validator: (val) => val.length < 6 ? "Atleast 6 char's": null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.pinkAccent,
                  child: Text("Register"),
                  onPressed: ()async{
                    if(_formkey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = "Enter a valid Email";
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w100, fontSize: 12.0),
                )
              ],
            )
          )
        ),
      );
    }
  
}