import 'package:brewcrew/Models/user.dart';
import 'package:brewcrew/Models/userdata.dart';
import 'package:brewcrew/Services/database_services.dart';
import 'package:brewcrew/Shared/constants.dart';
import 'package:brewcrew/Shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsSheet extends StatefulWidget {
  @override
  _SettingsSheetState createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  

  //Values
  String _currentuser, _currentSugar;
  int _currentStrength;
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DataBaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
        UserData userData = snapshot.data;
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Text("Updating Your Brew"),
              SizedBox(height: 8.0,),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _currentuser ?? userData.name,
                      decoration: textInputDecoration.copyWith(
                        hintText: "Name"
                      ),
                      validator: (val) => val.isEmpty? "Enter a Valid Name" : null,
                      onChanged: (val) => _currentuser = val,
                    ),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField(
                      value: _currentSugar ?? userData.sugar,
                      decoration: textInputDecoration,
                      items: sugars.map((sugar){
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar suagrs'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugar = val),
                    ),
                    SizedBox(height: 8.0,),
                    Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor: Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) => setState(() => _currentStrength = val.round()),
                    ),
                    SizedBox(height: 8.0,),
                    RaisedButton(
                      color: Colors.pink[300],
                      child: Text('Update'),
                      onPressed: ()async{
                        await DataBaseService(uid: userData.uid).updateUserData(
                          _currentSugar ?? userData.sugar, 
                          _currentuser ?? userData.name,
                          _currentStrength ?? userData.strength,
                          );
                          Navigator.pop(context);
                      },
        
                    )
                  ],
                ),

              )
            ],
          ),
        );
        }
        else{
          return Loading();
        }
      }
    );
  }
}