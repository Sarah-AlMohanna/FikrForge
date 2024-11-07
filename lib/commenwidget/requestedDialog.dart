import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/configuration/theme.dart';
import 'package:provider/provider.dart';

import '../models/IdeaModel.dart';
import '../provider/dataProvider.dart';
import '../provider/user_provider.dart';

class RequestedDialog extends StatelessWidget {
  final List<Map<String, dynamic>> requested;

  RequestedDialog({required this.requested});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) {
        return AlertDialog(
          title: Text('Requested List' , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
          content: SizedBox(
            width: double.maxFinite, // Make the dialog wide enough
            child: ListView.builder(
              itemCount: requested.length,
              itemBuilder: (context, index) {
                final request = requested[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            EasyLoading.show();
                            Map<String, dynamic>? data =  await Provider.of<UserProvider>(context , listen: false).getUserData(request["invest_id"]??"" , justData: true);
                            EasyLoading.dismiss();
                            if(data != null){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('User Information'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('Full Name: ${data['fill_name']}'),
                                          Text('Username: ${data['user_name']}'),
                                          Text('Email: ${data['email']}'),
                                          Text('Phone Number: ${data['phone_number']}'),
                                          Text('Account Type: ${data['account_type']}'),
                                          // Text('Birth Date: ${data['birth_date']}'),
                                          // Text('User ID: ${data['user_id']}'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              EasyLoading.showError("There is an error!");
                            }

                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(request["invest_name"]??""),
                              Text('${request["invest_budget"]??"0"} SAR'),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                EasyLoading.show();
                                await Provider.of<DataProvider>(context, listen: false).acceptInvestRequest(request , context );
                                Idea IdeaData = Idea.fromJson(request);

                                await Provider.of<DataProvider>(context, listen: false).changeIdeaStatus(IdeaData );


                                EasyLoading.dismiss();
                                setState(() {
                                  requested.remove(request);
                                });
                              },
                              child: Card(color: Theme_Information.Primary_Color.withOpacity(0.8) , child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Accept' , style: ourTextStyle(color: Theme_Information.Color_1),),
                              )),
                            ),
                            InkWell(
                              onTap: () async {
                                EasyLoading.show();
                                await Provider.of<DataProvider>(context, listen: false).rejectInvestRequest(request , context );
                                EasyLoading.dismiss();
                                //
                                setState(() {
                                  requested.remove(request);
                                });

                              },
                              // child: Text('Reject', style: ourTextStyle(),),
                              child: Card(color: Theme_Information.Color_10!.withOpacity(0.8) , child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Reject' , style: ourTextStyle(color: Theme_Information.Color_1),),
                              )),

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      }
    );
  }
}