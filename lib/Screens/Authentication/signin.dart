import 'package:brewcrew/Services/auth_service.dart';
import 'package:brewcrew/Shared/constants.dart';
import 'package:brewcrew/Shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  //Text Field Values
  String email = '';
  String password = '';

  //helper variables
  String error = '';
  bool loading = false; 

  @override
  Widget build(BuildContext context) {
    return loading ?Loading():Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        actions: <Widget>[
          FlatButton.icon(
            label: Text("Register", style: TextStyle(color: Colors.white),),
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
          key: _formKey,
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
                validator: (val) => val.length < 6 ? "At least 6 char's" : null,
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
                child: Text("Sign In"),
                onPressed: ()async{
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() { 
                        error = "Couldn't Find User\nTry Registering or check credentials";
                        loading = false;
                        });
                    }
                  }
                  print("Email $email Password $password");
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