import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreServices {
  var user = FirebaseFirestore.instance.collection('clients');

  Future<StoreDataResult> addClientInfoToDB({
    required String uid,
    required String email ,
    required String password ,
    required BuildContext context,
  }) async {
    StoreDataResult res;
    bool result = false;
    String message = '';
    try {
      await user.doc(uid).set(getEmptyUser(email: email, password: password, uid: uid)).then(
        (value) {
          result = true;
          message = 'Client Data added successfully';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
      ).catchError(
        (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message.toString())),
          );
          result = false;
          message = 'Error occurred while storing patient data';
        },
      );
      return StoreDataResult(success: result, message: message);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return res = StoreDataResult(
          success: false,
          message: 'failed to store patient data \n' + e.toString());
    }
  }

  Future<bool> checkExistingUser(String uid) async {
    DocumentSnapshot snapshot = await user.doc(uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
}

class StoreDataResult {
  StoreDataResult({
    this.uid = '',
    required this.success,
    this.message = '',
  });
  final String uid, message;
  final bool success;
}

class AddDataToFireStore {
  AddDataToFireStore({
    required this.success,
    required this.error,
  });
  final String error;
  final bool success;
}

Map<String, dynamic> getEmptyUser({required String email,required String password ,required String uid }) {
  Map<String, dynamic> user = {
    "email":email,
    "password":password,
    "uid":uid,
    "nom": "",
    "tel": '',
    "image": "",
    "mainPosition": {
      "lat": 0.0,
      "lan": 0.0,
      "address":"",
      "wilaya":"",
      "ville":"",
      "type":"",
    },
    "favorite":[],
    "rating": {
      "star": 0,
      "nbr": 0,
      "say": [""]
    },
    "online": true,
    "nbr_commande": 0,
    "dette": 0,
    "contry": "Algeria",
    "countryId": "213",
    "date_creation": DateTime.now(),
    "date_update": DateTime.now(),
    "token":'',
  };

  return user;
}