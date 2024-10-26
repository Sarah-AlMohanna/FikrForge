import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/configuration/theme.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import '../../commenwidget/button.dart';
import '../../commenwidget/textInput.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';

class RegisteredSuccessfullyPage extends StatefulWidget {
  const RegisteredSuccessfullyPage({super.key,required this.userProfile});
  final UserProfile? userProfile;

  @override
  State<RegisteredSuccessfullyPage> createState() => _RegisteredSuccessfullyPageState();
}

class _RegisteredSuccessfullyPageState extends State<RegisteredSuccessfullyPage> {
  int step = 0 ;
  TextEditingController bio = TextEditingController();
  html.File? profileImage;
  final FirebaseStorage _storage = FirebaseStorage.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: size_H(100),
          ),

          InkWell(
              onTap: (){
                setState(() {
                  step = 0 ;
                });
              },
              child: Center(child: Image.asset("assets/images/logo.png"  , scale: 6,))),
          const SizedBox(height: 32),

          if(step == 0 || step == 1)
          buildContainer(),

          if(step == 2)
            buildContainerImage(),

          if(step == 3)
            buildContainerBio(),


          Container(
            height: size_H(50),
          ),
          Column(
            children: [
              Container(
                width: (200),
                child: T9ButtonReverce(
                  onPressed: () async {
                    addStep();
                  },
                  textContent: step != 3 ? "Next" : "Save",
                ),
              ),
              if(step == 2 || step == 3)
                const SizedBox(height: 15),
                if(step == 2 || step == 3)
                InkWell(
                  onTap: (){
                    addStep();
                  },
                  child: Container(
                    width: (200),
                    child: Center(child: Text("Skip" , style: ourTextStyle(color: Theme_Information.Primary_Color ,fontWeight: FontWeight.bold , ),)),
                  ),
                ),
            ],
          ),


        ],
      ),
    );
  }

  Future<void> addStep() async {
    if(step == 2){
      EasyLoading.show();
      await _uploadImage();
      EasyLoading.dismiss();
      setState(() {
        step = step + 1 ;
      });
    } else if(step == 3){
      EasyLoading.show();
      await uploadBio();
      await Provider.of<UserProvider>(context, listen: false).loginUserBase(context, widget.userProfile?.email??"", widget.userProfile?.password??"");
    } else if (step < 3) {
      setState(() {
        step = step + 1;
      });
    }
  }

  Container buildContainer() {
    String title = "";
    String subTitle = "";
    if (step == 0) {
      title = step0Title;
      subTitle = step0Text;
    }  else {
      title = step1Title;
      subTitle = step1Text;
    }
    return Container(
      height: size_H(300),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  title,
                  style:
                      ourTextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: size_H(20),
                ),
                Text(
                  subTitle,
                  style: ourTextStyle(fontSize: 16),
                ),
              ],
            ),
          );
  }


  Widget buildContainerImage(){
    return Container(
      height: size_H(300),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            "Add Profile Image",
            style:
            ourTextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (profileImage != null)
                Image.network(
                  html.Url.createObjectUrl(profileImage!),
                  height:size_H(150),
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
                          height:size_H(150),
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

        ],
      ),
    );
  }


  Widget buildContainerBio(){
    return Container(
      height: size_H(300),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            "Add Bio",
            style:
            ourTextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          T9EditTextStyle("", bio,
              maxLines: 5,
              textInputType: TextInputType.multiline),
          const SizedBox(
            height: (10),
          ),

        ],
      ),
    );
  }



  String step0Title = "Welcome to FikrForge!" ;
  String step0Text = """
  We're excited to have you on board! FikrForge is an innovative platform designed to empower entrepreneurs and investors by transforming ideas into reality. Whether you're looking to showcase your business concepts or find the right investment opportunities, FikrForge is here to help you every step of the way.
  """;

  String step1Title = "Getting Started" ;
  String step1Text = """
  To get started, explore your profile settings, submit your first idea, or connect with potential investors. Our platform is designed to foster collaboration and innovation, so don't hesitate to reach out to others in the community.
Thank you for joining FikrForge. Together, let's unleash the full potential of human innovation!
  """;

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
        bio: bio.text,
        profileImage: downloadUrl,
        fullName: "",
        uid: widget.userProfile?.userId??""
    );
  }

  Future<void> uploadBio() async {
    await Provider.of<DataProvider>(context, listen: false).updateUserProfile(
        bio: bio.text,
        profileImage: "",
        fullName: "",
        uid: widget.userProfile?.userId??""
    );
  }


}
