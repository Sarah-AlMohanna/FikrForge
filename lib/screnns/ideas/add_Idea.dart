import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  const AddIdeaPage({super.key ,required this.backToHome});
  final Function() backToHome ;
  @override
  State<AddIdeaPage> createState() => _AddIdeaPageState();
}

class _AddIdeaPageState extends State<AddIdeaPage> {
  TextEditingController ideaTitle = TextEditingController();
  TextEditingController ideaDescription = TextEditingController();
  html.File? _imageFile;
  html.File? _file;
  TextEditingController additionalInfo = TextEditingController();

  List<String> typeOfInvestors = ["Financial", "Mentorship", "Resources", "Other"] ;
  String? typeOfInvestorsSelected ;
  TextEditingController typeOfInvestorsOther = TextEditingController();


  List<String> ideaCategory = ["technology", "healthcare", "education", "Other"] ;
  String? ideaCategorySelected ;
  TextEditingController ideaCategoryOther = TextEditingController();


  TextEditingController targetAudience = TextEditingController();
  TextEditingController businessModel = TextEditingController();
  /// list
  List<html.File> _supportingDocs = [];

  List<String> intellectualPropertyStatus = ["Not Protected", "Pending Application", "Granted"] ;
  String? intellectualPropertyStatusSelected ;


  double _minValue = 1000;
  double _maxValue = 50000;
  double _currentMinValue = 2500;
  double _currentMaxValue = 7500;


  final FirebaseStorage _storage = FirebaseStorage.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      // appBar: AppBar(
      //   backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
      //   iconTheme: IconThemeData( color: Theme_Information.Color_1),
      //   title: Text("Add your Idea" , style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 16 , color: Theme_Information.Color_1),),
      //   actions: [ Image.asset("assets/images/logo.png" , width:size_W(30),color: Theme_Information.Color_1,),],
      //
      // ),
      ///
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildContainer(
                      title: "Idea title",
                      isRequired: true,
                      textEditingController: ideaTitle,
                    ),
                    const SizedBox(
                      height: (16),
                    ),
                    buildContainer(
                        title: "Idea Description",
                        isRequired: true,
                        textEditingController: ideaDescription,
                        maxLines: 5,
                        textInputType: TextInputType.multiline
                    ),
                    const SizedBox(
                      height: (16),
                    ),


                    buildUploadFile(
                      title: "File",
                      isRequired: true,
                    ),

                    const SizedBox(
                      height: (16),
                    ),
                    buildContainer(
                      title: "Additional Info",
                      // isRequired: true,
                      textEditingController: additionalInfo,
                    ),
                    const SizedBox(
                      height: (16),
                    ),
                    buildContainerDropDown(
                      items: typeOfInvestors,
                      selectedITem: typeOfInvestorsSelected,
                      title: "Type of Investors",
                      onUserSelect: (selectedItem){
                          typeOfInvestorsSelected = selectedItem ;
                      },
                      isRequired: true,
                      textEditingController: typeOfInvestorsOther,
                    ),
                    const SizedBox(
                      height: (16),
                    ),

                    buildContainerDropDown(
                      items: ideaCategory,
                      selectedITem: ideaCategorySelected,
                      title: "Idea Category",
                      onUserSelect: (selectedItem){
                          ideaCategorySelected = selectedItem ;
                      },
                      isRequired: true,
                      textEditingController: ideaCategoryOther,
                    ),
                    const SizedBox(
                      height: (16),
                    ),
                    buildContainer(
                      title: "Target Audience",
                      // isRequired: true,
                      textEditingController: targetAudience,
                    ),
                    const SizedBox(
                      height: (16),
                    ),

                    buildContainer(
                      title: "Business Model",
                      // isRequired: true,
                      textEditingController: businessModel,
                    ),

                    const SizedBox(
                      height: (16),
                    ),

                    buildContainerSlider(
                      title: "Budget Estimate",
                      isRequired: true
                    ),

                    const SizedBox(
                      height: (16),
                    ),

                    buildUploadDocuments(
                      title: "Supporting Documents",
                      isRequired: true,
                    ),

                    const SizedBox(
                      height: (16),
                    ),


                    buildContainerDropDown(
                      selectedITem: intellectualPropertyStatusSelected,
                      items: intellectualPropertyStatus,
                      title: "Intellectual Property Status",
                      onUserSelect: (selectedItem){
                          intellectualPropertyStatusSelected = selectedItem ;
                      },
                      isRequired: true,
                      textEditingController: TextEditingController(),
                    ),

                    const SizedBox(
                      height: (16),
                    ),


                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: (300),
                        child: T9ButtonReverce(
                          onPressed: () async {


                            if(ideaTitle.text.isEmpty){
                              EasyLoading.showError("Please add idea title");
                            } else if(ideaDescription.text.isEmpty){
                              EasyLoading.showError("Please add idea description");
                            } else if(_file == null){
                              EasyLoading.showError("Please add the file");
                            } else if(typeOfInvestorsSelected == null || (typeOfInvestorsSelected!.toLowerCase() == "other" &&typeOfInvestorsOther.text.isEmpty )){
                              EasyLoading.showError("Please select type of investors");
                            }  else if(ideaCategorySelected == null || (ideaCategorySelected!.toLowerCase() == "other" && ideaCategoryOther.text.isEmpty )){
                              EasyLoading.showError("Please select idea category");
                            } else if(intellectualPropertyStatusSelected == null  ){
                              EasyLoading.showError("Please select intellectual property status");
                            } else {
                              EasyLoading.show();

                              String ideaCategory = ideaCategorySelected!.toLowerCase() == "other" ? ideaCategoryOther.text : ideaCategorySelected??"" ;
                              String typeOfInvestors = typeOfInvestorsSelected!.toLowerCase() == "other" ? typeOfInvestorsOther.text : typeOfInvestorsSelected??"" ;
                              String? imageURL =  _imageFile == null ? null : await _uploadImage();
                              String? fileURL =   _file == null ? null :  await _uploadfile();
                              List<String> urls = _supportingDocs.isEmpty ? [] : await _uploadSupportingDocs(_supportingDocs);


                              Idea ideaData = Idea(
                                title: ideaTitle.text, // Req
                                userId: Provider.of<UserProvider>(context , listen: false).userProfile?.userId??"",
                                description: ideaDescription.text,  // Req
                                image: imageURL ??"",
                                file: fileURL ??"",
                                additionalInfo: additionalInfo.text,
                                typeInvestor: typeOfInvestors,
                                ideaCategory: ideaCategory,
                                targetAudience: targetAudience.text,
                                businessModel: businessModel.text,
                                budgetMinimum: _currentMinValue.toString(), //Req
                                budgetMaximum: _currentMaxValue.toString(), //Req
                                supportingDocuments: urls,
                                intellectualPropertyStatus: intellectualPropertyStatusSelected,   //Req
                                uploadedAt: null,
                                amount: "0",
                              );

                              await Provider.of<DataProvider>(context, listen: false).addUserIdea(ideaData);

                              EasyLoading.showSuccess("The idea sent successfully");
                              Navigator.pushReplacementNamed(context, '/homePageEntrepreneur');

                              ///
                              // EasyLoading.show();
                              // await _uploadImage();
                              //
                              // Navigator.of(context).pop(true);
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

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (_imageFile != null)
                    Image.network(
                      html.Url.createObjectUrl(_imageFile!),
                      height: 200,
                    ),
                  SizedBox(height: 20),
              
                  Card(
                    child: InkWell(
                      onTap: (){
                        _pickImage(file: _imageFile , callBack: (file) {
                          setState(() {
                            _imageFile = file ;
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // color: Theme_Information.Primary_Color.withOpacity(0.5),
                          width: size_W(150),
                          height: size_H(100),
                          child: Center(child: Text("Pick Image" ,  style: ourTextStyle(fontSize: 15),)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: (10),
                  ),
              
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Container buildContainer({
    required String title ,
    required TextEditingController textEditingController ,
    int? maxLines ,
    bool isRequired = false ,
    bool isOther = false ,
    TextInputType textInputType = TextInputType.text ,
}) {
    return Container(
                    width: size_W(200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 0) ,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    title,
                                    style: ourTextStyle(fontSize: 15),
                                  ),
                                  if(isRequired)
                                  Text(
                                    " * ",
                                    style: ourTextStyle(fontSize: 15 , color: Theme_Information.Color_10),
                                  ),
                                ],
                              ),
                            )),
                        T9EditTextStyle(
                          "",
                          textEditingController,
                            maxLines: maxLines,
                            textInputType: textInputType
                        ),
                      ],
                    ),
                  );
  }

  Container buildContainerSlider({
    required String title ,
    // required TextEditingController textEditingController ,
    // int? maxLines ,
    bool isRequired = false ,
    // bool isOther = false ,
    // TextInputType textInputType = TextInputType.text ,
  }) {
    return Container(
      width: size_W(200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 0, bottom: 0) ,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: ourTextStyle(fontSize: 15),
                    ),
                    if(isRequired)
                      Text(
                        " * ",
                        style: ourTextStyle(fontSize: 15 , color: Theme_Information.Color_10),
                      ),
                  ],
                ),
              )),
          Container(
            padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
            margin: const EdgeInsets.only(
                left: 20, right: 20, top: 0, bottom: 0) ,
            child: RangeSlider(
              min: _minValue,
              max: _maxValue,
              activeColor: Theme_Information.Primary_Color,
              values: RangeValues(_currentMinValue, _currentMaxValue),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentMinValue = values.start;
                  _currentMaxValue = values.end;
                });
              },
              divisions: 20,
              labels: RangeLabels(
                '${_currentMinValue.toStringAsFixed(0)}SAR',
                '${_currentMaxValue.toStringAsFixed(0)}SAR',
              ),
            ),
          ),
        ],
      ),
    );
  }

///
  Widget buildContainerDropDown({
    required String title,
    required String? selectedITem,
    required Function(String?) onUserSelect,
    required List<String> items,
    required TextEditingController textEditingController,
    int? maxLines,
    bool isRequired = false,
    TextInputType textInputType = TextInputType.text,
  }) {
    String? selectedItem = selectedITem;
    bool showTextField = selectedITem != null && selectedITem.toLowerCase() == "other";

    return Container(
        width: size_W(200),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: ourTextStyle(fontSize: 15,),
                      ),
                      if (isRequired)
                        Text(
                          " * ",
                          style: ourTextStyle(fontSize: 15, color: Theme_Information.Color_10),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                    padding:  EdgeInsets.only(right: size_W(20), left: size_W(20)),
                  width: size_W(200),
                child: Container(
                  decoration: BoxDecoration(
                    color:   Theme_Information.Color_9,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      padding:  EdgeInsets.only(right: size_W(5), left: size_W(5)),
                      value: selectedItem,
                      // underline: SizedBox(),
                      hint: Text('Select an option' , style: ourTextStyle(),),
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item , style: ourTextStyle(),),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem = newValue;
                          showTextField = newValue == 'Other';
                          textEditingController.clear();
                        });
                        onUserSelect(selectedItem);
                      },
                    ),
                  ),
                ),
              ),
              if (showTextField)
                const SizedBox(
                  height: (16),
                ),
              if (showTextField)
                buildContainer(
                  title: "$title (Other)",
                  // isRequired: true,
                  isOther: true,
                  textEditingController: textEditingController,
                ),
            ],
          );
        },
      ),
    );
  }
///



  Container buildUploadFile({
    required String title,
    bool isRequired = false ,
  }) {
    return Container(
      width: size_W(200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 0, bottom: 0),
              child: InkWell(
                onTap: () async {
                 await _pickImage(file: _file , callBack: (html.File? fileB){
                   setState(() {
                     _file = fileB ;
                   });
                 });
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      if(_file == null)
                      Icon(Icons.add , size: 15,),
                      if(_file == null)
                      SizedBox(width: 5,),
                      Row(
                        children: [
                          Text(
                            title,
                            style: ourTextStyle(fontSize: 15),
                          ),
                          if(isRequired)
                            Text(
                              " * ",
                              style: ourTextStyle(fontSize: 15 , color: Theme_Information.Color_10),
                            ),
                        ],
                      ),

                    ],
                  ),
                ),
              )),
        if(_file != null)
          Container(
            padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
            margin: const EdgeInsets.only(
                left: 20, right: 20, top: 0, bottom: 0),
            child: Container(
              height: size_H(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Text(_file?.name.split("/").last??" - " , maxLines: 1 , overflow: TextOverflow.ellipsis , style: ourTextStyle(),)),
                  SizedBox(width: 10,),
                  GestureDetector(
                      onTap: (){
                          setState(() {
                            _file = null;
                          });
                        },
                      child: Icon(Icons.remove_circle_outline_sharp))
                ],
              ),
            ),
          )

        ],
      ),
    );
  }


  Container buildUploadDocuments({
    required String title,
    bool isRequired = false ,
  }) {
    return Container(
      width: size_W(200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 0, bottom: 0),
              child: InkWell(
                onTap: () async {
                  // _supportingDocs
                 await _pickImageDocs();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.add , size: 15,),
                      SizedBox(width: 5,),
                      Row(
                        children: [
                          Text(
                            title,
                            style: ourTextStyle(fontSize: 15),
                          ),
                          if(isRequired)
                            Text(
                              " * ",
                              style: ourTextStyle(fontSize: 15 , color: Theme_Information.Color_10),
                            ),
                        ],
                      ),

                    ],
                  ),
                ),
              )),
        if(_supportingDocs.isNotEmpty)
          Column(
              children: List.generate(_supportingDocs.length, (index) {
                final item = _supportingDocs[index];
                return Container(
                  padding:  EdgeInsets.only(right: size_W(15), left: size_W(15)),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 0, bottom: 0),
                  child: Container(
                    height: size_H(40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: Text(item.name.split("/").last??" - " , maxLines: 1 , overflow: TextOverflow.ellipsis , style: ourTextStyle(),)),
                        SizedBox(width: 10,),
                        GestureDetector(
                            onTap: (){
                              setState(() {
                                _supportingDocs.remove(item);
                              });
                            },
                            child: Icon(Icons.remove_circle_outline_sharp))
                      ],
                    ),
                  ),
                );
              }),
            )
        ],
      ),
    );
  }


  Future<void> _pickImage({required html.File? file ,
    Function(html.File?)? callBack
  }) async {
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

    file = await completer.future;
    // _imageFile = await completer.future;
    setState(() {});
    if(callBack != null){
      callBack(file);
    }


  }

  Future<String?> _pickImageDocs() async {
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

    _supportingDocs.add(await completer.future) ;
    setState(() {});

  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    final fileName = _imageFile!.name;
    final destination = 'images/$fileName';

    final ref = _storage.ref(destination);
    await ref.putBlob(_imageFile!);

    final downloadUrl = await ref.getDownloadURL();


    // Idea ideaData = Idea(
    //   title: ideaTitle.text,
    //   userId: Provider.of<UserProvider>(context , listen: false).userProfile?.userId??"",
    //   description: ideaDescription.text,
    //   image: downloadUrl,
    //   uploadedAt: null,
    // );
    ///
    // Provider.of<DataProvider>(context, listen: false).addUserIdea(ideaData);
    return downloadUrl ;

    // print('Image uploaded successfully! URL: $downloadUrl');
  }

  Future<String?> _uploadfile() async {
    if (_file == null) return null;

    final fileName = _file!.name;
    final destination = 'files/$fileName';

    final ref = _storage.ref(destination);
    await ref.putBlob(_file!);

    final downloadUrl = await ref.getDownloadURL();


    // Idea ideaData = Idea(
    //   title: ideaTitle.text,
    //   userId: Provider.of<UserProvider>(context , listen: false).userProfile?.userId??"",
    //   description: ideaDescription.text,
    //   image: downloadUrl,
    //   uploadedAt: null,
    // );
    ///
    // Provider.of<DataProvider>(context, listen: false).addUserIdea(ideaData);
    return downloadUrl ;

    // print('Image uploaded successfully! URL: $downloadUrl');
  }
///
  // Future<String?> _uploadSupportingDocs(html.File? theFile) async {
  //   if (theFile == null) return null;
  //
  //   final fileName = theFile!.name;
  //   final destination = 'SupportingDocs/$fileName';
  //
  //   final ref = _storage.ref(destination);
  //   await ref.putBlob(theFile!);
  //
  //   final downloadUrl = await ref.getDownloadURL();
  //
  //
  //   // Idea ideaData = Idea(
  //   //   title: ideaTitle.text,
  //   //   userId: Provider.of<UserProvider>(context , listen: false).userProfile?.userId??"",
  //   //   description: ideaDescription.text,
  //   //   image: downloadUrl,
  //   //   uploadedAt: null,
  //   // );
  //   ///
  //   // Provider.of<DataProvider>(context, listen: false).addUserIdea(ideaData);
  //   return downloadUrl ;
  //
  //   // print('Image uploaded successfully! URL: $downloadUrl');
  // }
///

  Future<List<String>> _uploadSupportingDocs(List<html.File> supportingDocs) async {
    List<String> downloadUrls = [];

    for (final theFile in supportingDocs) {
      final fileName = theFile.name;
      final destination = 'SupportingDocs/$fileName';

      final ref = _storage.ref(destination);

      // Upload the file
      await ref.putBlob(theFile);

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();

      // Add the URL to the list
      downloadUrls.add(downloadUrl);
    }

    return downloadUrls;
  }


}
