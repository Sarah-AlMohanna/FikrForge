import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../models/user_profile_model.dart';


class UserProvider with ChangeNotifier{
  // notifyListeners();
  UserProfile? userProfile ;
  Map<String, dynamic>? adminData ;
  setUserProfile(UserProfile data){
    userProfile = data ;
    notifyListeners();
  }

  setAdminData(Map<String, dynamic> data){
    adminData = data ;
    notifyListeners();
  }

  bool isInvestor = false ;

  setIsInvestor(bool boolNew){
    isInvestor = boolNew  ;
    notifyListeners();
  }



  Future<void> loginUserBase(BuildContext context, String email, String password) async {
    EasyLoading.show();

    try {
     int? isAdmin = await checkAdminUser(email , password);  /// 1- admin , 2- admin (wrong password) , 3- not admin
     print("isAdmin_ ${isAdmin}");
      if(isAdmin != null && isAdmin == 1){ /// 1- admin
        print("Admin");

        EasyLoading.dismiss();
        Navigator.pushNamed(context, '/admin');

        return ;
      } else   if(isAdmin != null && isAdmin ==2 ){ /// 1- admin (wrong password)
        print("Admin _ (wrong password)");
        EasyLoading.showError("Password not correct");
        return ;
      }
      UserCredential userCredential = await loginUser(email, password);

      if (userCredential.user != null) {
        print("Login successful! User ID: ${userCredential.user!.uid}");
        Map<String, dynamic>? userData = await getUserData(userCredential.user!.uid);

        if (userData != null) {
          EasyLoading.dismiss();

          if (userData["account_type"] == "entrepreneur") {
            // Navigator.pushReplacementNamed(context, '/homePageEntrepreneur');
            if(kDebugMode){
              Navigator.pushNamed(context, '/homePageEntrepreneur');
            } else {
              Navigator.pushReplacementNamed(context, '/homePageEntrepreneur');
            }

          } else {
            setIsInvestor(true);
            /// investor
            if(kDebugMode){
              Navigator.pushNamed(context, '/homePageInvestor');
            } else {
              Navigator.pushReplacementNamed(context, '/homePageInvestor');
            }


          }
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError("Login failed");
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("An error occurred: $e");
    }
  }

  Future<UserCredential> loginUser(String email, String password) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } catch (e) {
      print("Error logging in: $e");
      throw e; // Throw the error to handle it in the UI
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid,
      {bool justData = false}) async {
    try {
      var userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.data() == null) {
        return null;
      }
      String jsonString = jsonEncode(userDoc.data());
      UserProfile userProfile = userProfileFromJson(jsonString);
      if (!justData) {
        await setUserProfile(userProfile);
      }
      return userDoc.data();
    } catch (e) {
      print("Error retrieving user data: $e");
      throw e; // Throw the error to handle it in the UI
    }
  }

  Future<int?> checkAdminUser(String email  , String password) async {
    try {
      var userDoc = await FirebaseFirestore.instance.collection('admin_users').get();
      if (userDoc.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in userDoc.docs) {
          print("dddd__ ${document.data()}");
          if(document["email"] == email){
            if(document["password"] == password){
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              await setAdminData(data);
              return 1 ;
            } else {
              return 2 ;
            }
          }
        }
      }
    } catch (e) {
      print("Error retrieving user data: $e");
      throw e; // Throw the error to handle it in the UI
    }
  }

  Future<bool?> registerUser(String email, String password , Map<String, dynamic> userData) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Access user information
      User? user = userCredential.user;
      if(user != null){
        await saveUserData("${user.uid}" , userData)!.then((value) {
          print("Done_5 ${value}");
          // return value ;
        });
        return true ;
      }
      // print('User registered: ${user!.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The email address is already in use by another account.');
        EasyLoading.showError('The email address is already in use by another account.');
        return null;
      } else {
        print('Error registering user: ${e.message}');
        EasyLoading.showError('Error registering user: ${e.message}');
        return null;
      }
    } catch (e) {
      print('Error registering user: $e');
      EasyLoading.showError('Error registering user: $e');
      // Handle generic errors
      return null;
    }
    return null;
  }

  Future<bool?> updateUserData(String uid, Map<String, dynamic> updatedData) async {
    try {
      // Reference to the user document
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(uid);

      // Update specific fields in the user document
      await userRef.update(updatedData);

      print('User data updated successfully!');
      return true ;
    } catch (e) {
      print('Error updating user data: $e');
      return false ;
    }
  }

  Future<bool?> updatePasswordinDatabase(String newPassword) async {
    try {
      // Reference to the user document
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userProfile!.userId);

      // Update specific fields in the user document
      // Update a single field in the user document
      await userRef.update({"password": newPassword});

      print('User data updated successfully!');
      return true ;
    } catch (e) {
      print('Error updating user data: $e');
      return false ;
    }
  }




  Future<bool?>? saveUserData(String uid, Map<String, dynamic> userData) async {
    try{
      userData["user_id"] = "$uid" ;
      UserProfile userProfile = UserProfile.fromJson(userData);

      await FirebaseFirestore.instance.collection('users').doc(uid).set(userProfile.toJson());

      return true ;
    } catch (e) {
      // Handle errors here
      print('Error entering data: $e');
      return null;
    }
  }

  Future<bool?> changeUserPassword(String email, String currentPassword, String newPassword) async {
    try {
      // Re-authenticate the user with their current credentials
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPassword);
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null){
        await user.reauthenticateWithCredential(credential);

        // Update the password
        await user.updatePassword(newPassword);

        print('Password updated successfully!');
        return true ;
      }
    } catch (e) {
      print('Error changing password: ${e}');
      // Handle errors, e.g., show a snackbar or display an error message
      throw e;
      return false ;
    }
  }

}