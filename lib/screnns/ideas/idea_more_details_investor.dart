import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import '../../commenwidget/investWidget.dart';
import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';
import '../../provider/dataProvider.dart';

class IdeaMoreDetailsPage extends StatefulWidget {
  const IdeaMoreDetailsPage({super.key , required this.item});
  final Idea item ;
  @override
  State<IdeaMoreDetailsPage> createState() => _IdeaMoreDetailsPageState();
}

class _IdeaMoreDetailsPageState extends State<IdeaMoreDetailsPage> {
  bool _isInvest = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () async {
      // _isInvest
      EasyLoading.show();
      _isInvest = await Provider.of<DataProvider>(context, listen: false).getIsInvest(widget.item )??false;
      EasyLoading.dismiss();
      print("_isInvest ${_isInvest  }");
      setState(() {});
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme_Information.Color_1),
        backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
        title: Text("Idea Details", style: ourTextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Theme_Information.Color_1),),
        actions: [
          Image.asset("assets/images/logo.png", width: size_W(30), color: Theme_Information.Color_1,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(widget.item.image != null && widget.item.image != "")
              Image.network("${widget.item.image}"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.item.title}",
                                  style: ourTextStyle(fontSize: 16,
                                      fontWeight: FontWeight.bold),),

                                Text("${widget.item.description}",
                                  style: ourTextStyle(),),
                              ],
                            ),
                          ),
                          Text(widget.item.status?.toUpperCase() ?? "",
                            style: ourTextStyle(fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  ),



                  buildCardData(data: widget.item.additionalInfo, title: "AdditionalInfo"),
                  buildCardData(data: widget.item.typeInvestor, title: "Type Investor"),
                  buildCardData(data: widget.item.ideaCategory, title: "Category"),
                  buildCardData(data: widget.item.businessModel, title: "Business Model"),
                  buildCardData(data: widget.item.targetAudience, title: "Target Audience"),
                  buildCardData(data: widget.item.intellectualPropertyStatus, title: "Intellectual Property Status"),

                  buildCardDataBudget(min: widget.item.budgetMinimum ?? "",
                      max: widget.item.budgetMaximum ?? "",
                      title: "Budget Estimate"),

                  buildCardDataSupporting(data: widget.item.supportingDocuments, title: "Supporting Documents"),

                  SizedBox(height: size_H(10),),
                  if(!_isInvest)
                    PaymentSelector(item: widget.item,),
                  SizedBox(height: size_H(10),),
                ],
              ),
            ),


          ],
        ),
      ),

    );
  }

  Widget buildCardData({String? data, String? title}) {
    if (data != null && data != "") {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? "",
                    style: ourTextStyle(fontWeight: FontWeight.bold),),
                  Text(data, style: ourTextStyle(),),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget buildCardDataBudget(
      { String min = "", String max = "", String? title}) {
    if (min != "" && max != "") {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? "",
                    style: ourTextStyle(fontWeight: FontWeight.bold),),
                  Text("${min}SAR - ${max}SAR", style: ourTextStyle(),),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget buildCardDataSupporting({List<String>? data , String? title}) {
    if (data != null && data.isNotEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ?? "",
                    style: ourTextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0 , right: 8),
                    child: Column(
                      children: List.generate(data!.length, (index) {
                        final item = data[index];
                        return InkWell(
                          onTap: (){
                            downloadFile(item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.attach_file),
                                // Text(item.split("/").last??"", style: ourTextStyle(),),
                                Text("attach #${index+1}", style: ourTextStyle(),),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                  // Text(data, style: ourTextStyle(),),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Future<void> downloadFile(String url) async {
    // html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
    // anchorElement.download = url;
    // anchorElement.click();
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.target = '_blank'; // Open in a new tab
    anchorElement.download = url;
    anchorElement.click();
  }


  Future<void> _showDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion', style: ourTextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
          content: Text('Are you sure you want to delete this item?' , style: ourTextStyle(),),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel' , style: ourTextStyle(),),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Delete', style: ourTextStyle(),),
              onPressed: () async {
                if(widget.item.idea_id != null && widget.item.idea_id != ""){
                  EasyLoading.show();
                  await FirebaseFirestore.instance.collection('user_ideas').doc(widget.item.idea_id).delete();
                  EasyLoading.showSuccess("The idea deleted successfully");
                  Navigator.pushReplacementNamed(context, '/homePageEntrepreneur');

                } else {
                  EasyLoading.showError("You cant delete this idea");
                }
              },
            ),
          ],
        );
      },
    );
  }



}
