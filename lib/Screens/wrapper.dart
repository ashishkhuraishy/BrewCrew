import 'package:brewcrew/Models/user.dart';
import 'package:brewcrew/Screens/Authentication/authentication.dart';
import 'package:brewcrew/Screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authentication();
    } else {
      return Home();
    }
  }
}
