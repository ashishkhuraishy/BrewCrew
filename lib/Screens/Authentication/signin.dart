import 'package:brewcrew/Services/auth_service.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Sign In"),
          onPressed: ()async{
            dynamic result = await _authService.signInAnon();
            if(result == null){
              print("Failed");
            }else{
              print("Signed In");
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}