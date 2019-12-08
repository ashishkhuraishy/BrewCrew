import 'package:brewcrew/Models/brew.dart';
import 'package:brewcrew/Models/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{

  //Firebase Instance
  final CollectionReference brewCollection = Firestore.instance.collection("Brews");

  //setting userId
  final String uid;
  DataBaseService({this.uid});

  //setting data for each user
  Future updateUserData(String sugar, String name, int strength)async{
    return await brewCollection.document(uid).setData(
    {
      "sugar" : sugar,
      "name" : name,
      "strength" : strength
    });
  }

  //Stream database changes
  Stream<List<Brew>> get brewSnapshots {
    return brewCollection.snapshots().map(_getBrews);
  }

  //Converting Snapshots Into Brew
  List<Brew> _getBrews(QuerySnapshot snapshot){
    return snapshot.documents.map((docs){
      return Brew(
        name: docs.data['name'],
        sugar: docs.data['sugar'],
        strength: docs.data['strength']
      );
    }).toList();
  }


  //Stream userdata
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots().map(_userDatFormSnapShot);
  }

  //UserData from Snapshot
  UserData _userDatFormSnapShot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugar: snapshot.data['sugar'],
      strength: snapshot.data['strength'],
    );
  }

}