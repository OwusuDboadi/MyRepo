import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:censorapp/models/census_model.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('citizens');

  Future updateUserData(String firstName, String lastName, int age, String gender, String address) async {
    return await userCollection.document().setData({
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'address': address,
    });
  }


  //census list from snapshot
  List <census_model> _censusListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return census_model(
        firstName:doc.data['firstname'] ?? '',
        lastName:doc.data['lastname'] ?? '',
        age:doc.data['email'] ?? '',
        gender:doc.data['age'] ?? 0,
        address:doc.data['region'] ?? '',

      );
    }).toList();
  }

  //get Census stream
  Stream<List<census_model>> get census{
    return userCollection.snapshots()
        .map(_censusListFromSnapshot);
  }



}