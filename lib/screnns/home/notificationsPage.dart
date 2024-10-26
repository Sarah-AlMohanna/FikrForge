import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/textInput.dart';
import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key });

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  List<Map<String, dynamic>> notificationsList = [] ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      EasyLoading.show();
      await Provider.of<DataProvider>(context, listen: false).getNotificationsData(notificationsList);
      EasyLoading.dismiss();
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size_H(10),),
        Expanded(
          child: ListView.builder(
            itemCount: notificationsList.length,
            itemBuilder: (context, index) {
              final item = notificationsList[index];

             final time =  item["notification_date_time"] as Timestamp ;

              return Card(
                child: ListTile(
                  onTap: (){
                    if(item["notification_action"] == "enter_to_idea"){
                      Idea data = Idea.fromJson(item);
                      Navigator.pushNamed(
                        context,
                        '/ideaDetails',
                        arguments: data,
                      );
                    }
                    // Navigator.pushNamed(
                    //   context,
                    //   '/UserDetailsPage',
                    //   arguments: user,
                    // );
                  },
                  title: Text("${item["notification"]??""}" ),
                  // subtitle: Text(user.userName ?? ''),
                  trailing: Text("${time.toDate()}" ),
                  // leading: user.profileImage != null
                  //     ? Image.network(user.profileImage!, width: size_W(25),)
                  //     : Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" , width: size_W(25),),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
