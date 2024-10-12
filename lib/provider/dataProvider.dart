import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/IdeaModel.dart';
import '../models/generalListFireBase.dart';
import '../models/user_profile_model.dart';

class DataProvider with ChangeNotifier{
  // notifyListeners();


  Future<bool?>? updateUserProfile(
      {required String uid,required String fullName,required String bio,required String profileImage}) async {
    try {
      Map<String, dynamic> updates = {};
        updates["fill_name"] = fullName;
        updates["bio"] = bio;
        updates["profile_image"] = profileImage;

      // Update the user document in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).update(updates);

      return true;
    } catch (e) {
      // Handle errors here
      print('Error updating data: $e');
      return null;
    }
  }
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

  Future<bool?>? addUserIdea(Idea ideaData) async {
    try{

      await FirebaseFirestore.instance.collection('user_ideas').doc().set(ideaData.toJson());

      return true ;
    } catch (e) {
      // Handle errors here
      print('Error entering data: $e');
      return null;
    }
  }



  Future<List<Idea>?> getUsersIdeas(String userID) async {
    List<Idea> _list = [] ;
    // users
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // QuerySnapshot querySnapshot = await firestore.collection("user_ideas").get();

      QuerySnapshot querySnapshot = await firestore
          .collection("user_ideas")
          .where("user_id", isEqualTo: userID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          Idea data = Idea.fromJson(document.data() as Map<String, dynamic>);
          _list.add(data);
        }
        return _list ;
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


}