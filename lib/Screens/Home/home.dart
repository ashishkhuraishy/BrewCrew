import 'package:brewcrew/Models/brew.dart';
import 'package:brewcrew/Screens/Home/brewlist.dart';
import 'package:brewcrew/Screens/Home/settingsSheet.dart';
import 'package:brewcrew/Services/auth_service.dart';
import 'package:brewcrew/Services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _authService = AuthService();

  void showSettingsSheet(BuildContext context){
    showModalBottomSheet(
      context: context, builder: (context){
        return SettingsSheet();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DataBaseService().brewSnapshots,
        child: Scaffold(
        appBar: AppBar(
          title: Text("Brew Crew"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white,),
              onPressed: () => showSettingsSheet(context),
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white,),
              onPressed: () async{
                await _authService.signOut();
              },
            ),           
          ],
          backgroundColor: Colors.brown[900],
        ),
        body: Container(
          color: Colors.brown[100],
          child: BrewList()),
      ),
    );
  }
}