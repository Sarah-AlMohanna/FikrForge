import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forgeapp/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/IdeaModel.dart';
import '../models/generalListFireBase.dart';
import '../models/user_profile_model.dart';

class DataProvider with ChangeNotifier{
  // notifyListeners();


  Future<bool?>? updateUserProfile(
      {required String uid,required String fullName,required String bio,required String profileImage}) async {
    try {
      Map<String, dynamic> updates = {};
      if (fullName != "") updates["fill_name"] = fullName;
      if (bio != "") updates["bio"] = bio;
      if (profileImage != "") updates["profile_image"] = profileImage;

      // Update the user document in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).update(updates);

      return true;
    } catch (e) {
      // Handle errors here
      print('Error updating data: $e');
      return null;
    }
  }
  Future getUsersData( List<UserProfile> _list , {bool isIdeaUsers = false}) async {
    // users
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = isIdeaUsers
          ? await firestore
              .collection("users")
              .where("account_type", isEqualTo: "entrepreneur")
              .get()
          : await firestore.collection("users").get();

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

  Future<bool?>? acceptInvestRequest(Map<String, dynamic> investData , context  ) async {
    try{
      Idea IdeaData = Idea.fromJson(investData);

      Map<String, dynamic> data = {
        "invest_user_id" :"${investData["invest_id"]}",
        "invest_user_name" :"${investData["invest_name"]}",
        "invest_budget" :"${investData["invest_budget"]}",
        "accept_date_time": FieldValue.serverTimestamp(),
        ...IdeaData.toJson()
      };

      updateRequestItem(investData["request_id"] , "accepted");

      await FirebaseFirestore.instance.collection('invest_ideas').add(
          data
      ).then((value) async {
        await FirebaseFirestore.instance
            .collection("invest_ideas")
            .doc(value.id)
            .update({"invest_item_id": value.id});
      });

      Map<String, dynamic> extraData = {
        ...IdeaData.toJson(),
        "notification_action" :"enter_to_idea"
      };


      await sendNotificationToUser("${investData["invest_id"]??""}" , "You request to '${IdeaData.title}' has been accepted"  , context, extraData:extraData);

      return true ;
    } catch (e) {
      // Handle errors here
      print('Error entering data: $e');
      return null;
    }
  }


  Future<bool?>? rejectInvestRequest(Map<String, dynamic> investData , context ) async {
    try{
      Idea IdeaData = Idea.fromJson(investData);

      // Map<String, dynamic> data = {
      //   "invest_user_id" :"${investData["invest_id"]}",
      //   "invest_user_name" :"${investData["invest_name"]}",
      //   "invest_budget" :"${investData["invest_budget"]}",
      //   "accept_date_time": FieldValue.serverTimestamp(),
      //   ...IdeaData.toJson()
      // };
      //
      updateRequestItem(investData["request_id"] , "rejected");
      //
      // await FirebaseFirestore.instance.collection('invest_ideas').add(
      //     data
      // ).then((value) async {
      //   await FirebaseFirestore.instance
      //       .collection("invest_ideas")
      //       .doc(value.id)
      //       .update({"invest_item_id": value.id});
      // });

      Map<String, dynamic> extraData = {
        ...IdeaData.toJson(),
        "notification_action" :"enter_to_idea"
      };


      await sendNotificationToUser("${investData["invest_id"]??""}" , "You request to '${IdeaData.title}' has been rejected"  , context, extraData:extraData);

      return true ;
    } catch (e) {
      // Handle errors here
      print('Error entering data: $e');
      return null;
    }
  }


  Future updateRequestItem(String requestID ,  String status) async{
    try {
      Map<String, dynamic> updates = {
        "request_status" : status ,
      };
      // Update the user document in Firestore
      await FirebaseFirestore.instance.collection('user_ideas_invest_request').doc(requestID).update(updates);

      return true;
    } catch (e) {
      // Handle errors here
      print('Error updating data: $e');
      return null;
    }
  }

  Future<bool?>? getIsInvest(Idea ideaData) async {
    try{

      var data = await FirebaseFirestore.instance.collection('user_ideas_invest_request')
          .where("idea_id", isEqualTo: ideaData.idea_id)
          .where("invest_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      //

      if (data.docs.isNotEmpty) {
        return true ;
      }


    } catch (e) {
      // Handle errors here
      print('Error entering data: $e');
      return null;
    }
  }


  Future<bool?>? sendRequestToInvestIdea(Idea ideaData , context , int amountToPay ) async {
    try{
      Map<String, dynamic> data = {
        "invest_id" :"${FirebaseAuth.instance.currentUser?.uid??[]}",
        "invest_name" :Provider.of<UserProvider>(context , listen: false).userProfile?.fillName??"",
        "invest_budget" :amountToPay,
        "request_status" :"requested",
        "request_date_time": FieldValue.serverTimestamp(),
        ...ideaData.toJson()
      };

      await FirebaseFirestore.instance.collection('user_ideas_invest_request').add(
          data
      ).then((value) async {
        await FirebaseFirestore.instance
            .collection("user_ideas_invest_request")
            .doc(value.id)
            .update({"request_id": value.id});
      });

      Map<String, dynamic> extraData = {
        ...ideaData.toJson(),
        "notification_action" :"enter_to_idea"
      };

      await sendNotificationToUser(ideaData.userId??"" , "You have invest request for '${ideaData.title}' idea"  , context, extraData:extraData);
      return true ;
    } catch (e) {
      // Handle errors here
      print('Error entering data: $e');
      return null;
    }
  }


  Future<bool?>? sendNotificationToUser(String userId, String notification , context , {Map<String, dynamic>? extraData}) async {
    try{
      Map<String, dynamic> data = {
        "receiver_user_id" :userId,
        "sender_user_id" :FirebaseAuth.instance.currentUser?.uid??"",
        "sender_user_name" :"${Provider.of<UserProvider>(context , listen: false).userProfile?.fillName??""}",
        "notification" :notification,
        "notification_date_time": FieldValue.serverTimestamp(),
       if(extraData != null) ...extraData
      };
      await FirebaseFirestore.instance.collection('user_notifications').add(
          data
      ).then((value) async {
        await FirebaseFirestore.instance
            .collection("user_notifications")
            .doc(value.id)
            .update({"notification_id": value.id});
      });

      return true ;
    } catch (e) {
      // Handle errors here
      print('Error entering data: $e');
      return null;
    }
  }


  Future getNotificationsData(List<Map<String, dynamic>> _list ) async {
    // users
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
           await firestore
          .collection("user_notifications")
          .where("receiver_user_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid??"")
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // return data.docs.first.data() as Map<String, dynamic>;
          _list.add(document.data() as Map<String, dynamic>);
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }



  Future<List<Map<String, dynamic>>?> getRequestedData() async {
    List<Map<String, dynamic>> _list = [] ;
    // users
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
      await firestore
          .collection("user_ideas_invest_request")
          .where("request_status", isEqualTo: "requested")
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // return data.docs.first.data() as Map<String, dynamic>;
          _list.add(document.data() as Map<String, dynamic>);
        }
      }
      return _list ;
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> getInvestorData() async {
    List<Map<String, dynamic>> _list = [] ;
    // users
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
      await firestore
          .collection("invest_ideas")
          .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid??"")
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // return data.docs.first.data() as Map<String, dynamic>;
          _list.add(document.data() as Map<String, dynamic>);
        }
      }
      return _list ;
    } catch (e) {
      print('Error fetching data: $e');
    }
  }



  Future<bool?>? addUserIdea(Idea ideaData) async {
    try{

      await FirebaseFirestore.instance.collection('user_ideas').add(ideaData.toJson()).then((value) async {
        await FirebaseFirestore.instance
            .collection("user_ideas")
            .doc(value.id)
            .update({"idea_id": value.id});
      });

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


  Future<List<Idea>?> getInvestmentIdeas(String userID) async {
    List<Idea> _list = [] ;
    // users
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // QuerySnapshot querySnapshot = await firestore.collection("user_ideas").get();

      QuerySnapshot querySnapshot = await firestore
          .collection("invest_ideas")
          .where("invest_user_id", isEqualTo: userID)
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