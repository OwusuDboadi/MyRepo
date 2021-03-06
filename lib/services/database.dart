import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:censorapp/models/citizen.dart';
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


  //citizen list from snapshot:

  List<Citizen> _citizenListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
        return Citizen(
          firstName: doc.data['firstName'] ?? '',
          lastName: doc.data['lastName'] ?? '',
          age: doc.data['age'] ?? 0,
          gender: doc.data['gender'] ?? '',
          address: doc.data['address'] ?? ''
        );
    }).toList();
  }





  Stream<List<Citizen>> get citizen{

    return userCollection.snapshots().map(_citizenListFromSnapshot);
  }


//  //census list from snapshot
//  List <census_model> _censusListFromSnapshot(QuerySnapshot snapshot){
//    return snapshot.documents.map((doc){
//      return census_model(
//        firstName:doc.data['firstname'] ?? '',
//        lastName:doc.data['lastname'] ?? '',
//        age:doc.data['age'] ?? '',
//        gender:doc.data['gender'] ?? 0,
//        address:doc.data['address'] ?? '',
//
//      );
//    }).toList();
//  }

  //get Citiezen stream



//  //get Census stream
//  Stream<List<census_model>> get census{
//    return userCollection.snapshots()
//        .map(_censusListFromSnapshot);
//  }



}