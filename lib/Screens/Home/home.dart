import 'package:brewcrew/Services/auth_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person, color: Colors.white,),
            onPressed: () async{
              await _authService.signOut();
            },
          )
        ],
      ),
    );
  }
}