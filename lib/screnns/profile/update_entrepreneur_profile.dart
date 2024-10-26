import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/configuration/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '../../commenwidget/button.dart';
import '../../commenwidget/textInput.dart';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key, required this.userProfile});

  final UserProfile? userProfile;

  @override
  State<UpdateProfile> createState() =>
      _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController fullName = TextEditingController();
  TextEditingController bio = TextEditingController();
  html.File? profileImage;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullName.text = widget.userProfile?.fillName??"";
    bio.text = widget.userProfile?.bio??"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
        iconTheme: IconThemeData(color: Theme_Information.Color_1),
        title: Text(
          "Update Profile",
          style: ourTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Theme_Information.Color_1),
        ),
        actions: [
          Image.asset(
            "assets/images/logo.png",
            width: size_W(30),
            color: Theme_Information.Color_1,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "",
              style: ourTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [


                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (profileImage != null)
                          Image.network(
                            html.Url.createObjectUrl(profileImage!),
                            height: 200,
                          ),
                        if (profileImage == null)
                        SizedBox(width: 10),
                        if (profileImage == null)
                        InkWell(
                          onTap: (){
                            _pickImage();
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Image.network(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                  height: 100,
                                ),
                              ),
                              Positioned.fill(child: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.add),
                              )),

                            ],
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: (10),
                    ),

                    Container(
                      width: size_W(200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(
                                  right: size_W(15), left: size_W(15)),
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 0, bottom: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Full Name",
                                  style: ourTextStyle(fontSize: 15),
                                ),
                              )),
                          T9EditTextStyle(
                            "",
                            fullName,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: (16),
                    ),
                    Container(
                      width: size_W(200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(
                                  right: size_W(15), left: size_W(15)),
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 0, bottom: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Bio",
                                  style: ourTextStyle(fontSize: 15),
                                ),
                              )),
                          T9EditTextStyle("", bio,
                              maxLines: 5,
                              textInputType: TextInputType.multiline),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: (16),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: (300),
                        child: T9ButtonReverce(
                          onPressed: () async {
                            if (fullName.text.isEmpty) {
                              EasyLoading.showError("Please add your full name");
                            } else if (bio.text.isEmpty) {
                              EasyLoading.showError(
                                  "Please add your bio");
                            } else if (profileImage == null) {
                              EasyLoading.showError("Please add your profile image");
                            } else {
                              EasyLoading.show();
                              await _uploadImage();
                              EasyLoading.showSuccess(
                                  "The profile updated successfully");
                              Navigator.of(context).pop(true);
                            }
                          },
                          textContent: "Update Profile",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: (10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final completer = Completer<html.File>();
    final input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((e) {
      final files = input.files!;
      if (files.isNotEmpty) {
        completer.complete(files[0]);
      }
    });

    profileImage = await completer.future;
    setState(() {});
  }

  Future<void> _uploadImage() async {
    if (profileImage == null) return;

    final fileName = profileImage!.name;
    final destination = 'profile_images/$fileName';

    final ref = _storage.ref(destination);
    await ref.putBlob(profileImage!);

    final downloadUrl = await ref.getDownloadURL();


   await Provider.of<DataProvider>(context, listen: false).updateUserProfile(
      bio: bio.text??"",
      fullName: fullName.text??"",
      profileImage: downloadUrl,
      uid: widget.userProfile?.userId??""
    );
  }
}
