import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/generalListFireBase.dart';
import '../models/user_profile_model.dart';

class DataProvider with ChangeNotifier{
  // notifyListeners();


  Future getUsersData( List<UserProfile> _list) async {
    // users
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore.collection("users").get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          UserProfile userProfile = UserProfile.fromJson(document.data() as Map<String, dynamic>);
          _list.add(userProfile);
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


}