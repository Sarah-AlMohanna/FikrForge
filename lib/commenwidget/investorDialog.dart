import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/configuration/theme.dart';
import 'package:provider/provider.dart';

import '../provider/dataProvider.dart';
import '../provider/user_provider.dart';

class InvestorDialog extends StatelessWidget {
  final List<Map<String, dynamic>> investors;

  InvestorDialog({required this.investors});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) {
        return AlertDialog(
          title: Text('Investors List' , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
          content: SizedBox(
            width: size_W(350),
            child: ListView.builder(
              itemCount: investors.length,
              itemBuilder: (context, index) {
                final invest = investors[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            EasyLoading.show();
                            log("eeee ${invest["invest_id"]}");

                            Map<String, dynamic>? data =  await Provider.of<UserProvider>(context , listen: false).getUserData(invest["invest_user_id"]??"" , justData: true);
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
                              Text(invest["invest_user_name"]??""),
                              Text('${invest["invest_budget"]??"0"} SAR'),
                            ],
                          ),
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