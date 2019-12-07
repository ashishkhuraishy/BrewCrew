import 'package:brewcrew/Screens/Authentication/register.dart';
import 'package:brewcrew/Screens/Authentication/signin.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isSignedIn = true;

  void toggle() {
    setState(() {
      isSignedIn = !isSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignedIn ? SignIn(toggle: toggle) : Register(toggle: toggle);
  }
}
