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
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';

class AddIdeaPage extends StatefulWidget {
  const AddIdeaPage({super.key});

  @override
  State<AddIdeaPage> createState() => _AddIdeaPageState();
}

class _AddIdeaPageState extends State<AddIdeaPage> {
  TextEditingController ideaTitle = TextEditingController();
  TextEditingController ideaDescription = TextEditingController();
  html.File? _imageFile;
  final FirebaseStorage _storage = FirebaseStorage.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
        iconTheme: IconThemeData( color: Theme_Information.Color_1),
        title: Text("Add your Idea" , style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 16 , color: Theme_Information.Color_1),),
        actions: [ Image.asset("assets/images/logo.png" , width:size_W(30),color: Theme_Information.Color_1,),],

      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text("" , style: ourTextStyle( fontSize: 16 , fontWeight: FontWeight.w600),),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: size_W(200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 0, bottom: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Idea Title",
                                  style: ourTextStyle(fontSize: 15),
                                ),
                              )),
                          T9EditTextStyle(
                            "",
                            ideaTitle,
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
                              padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 0, bottom: 0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Idea Description",
                                  style: ourTextStyle(fontSize: 15),
                                ),
                              )),
                          T9EditTextStyle(
                            "",
                            ideaDescription,
                            maxLines: 5,
                            textInputType: TextInputType.multiline
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: (16),
                    ),


                    if (_imageFile != null)
                      Image.network(
                        html.Url.createObjectUrl(_imageFile!),
                        height: 200,
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Pick Image'),
                    ),
                    const SizedBox(
                      height: (10),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: (300),
                        child: T9ButtonReverce(
                          onPressed: () async {
                            if(ideaTitle.text.isEmpty){
                              EasyLoading.showError("Please add idea title");
                            } else if(ideaDescription.text.isEmpty){
                              EasyLoading.showError("Please add idea description");
                            } else if(_imageFile == null){
                              EasyLoading.showError("Please add idea image");
                            } else {
                              EasyLoading.show();
                              await _uploadImage();
                              EasyLoading.showSuccess("The idea sent successfully");
                              Navigator.of(context).pop(true);
                            }

                          },
                          textContent: "Add your Idea",
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

    _imageFile = await completer.future;
    setState(() {});
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    final fileName = _imageFile!.name;
    final destination = 'images/$fileName';

    final ref = _storage.ref(destination);
    await ref.putBlob(_imageFile!);

    final downloadUrl = await ref.getDownloadURL();


    Idea ideaData = Idea(
      title: ideaTitle.text,
      userId: Provider.of<UserProvider>(context , listen: false).userProfile?.userId??"",
      description: ideaDescription.text,
      image: downloadUrl,
      uploadedAt: null
    );
    Provider.of<DataProvider>(context, listen: false).addUserIdea(ideaData);


    print('Image uploaded successfully! URL: $downloadUrl');
  }


}
