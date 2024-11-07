import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/button.dart';
import '../../configuration/theme.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';

class EntrepreneurProfilePage extends StatefulWidget {
  EntrepreneurProfilePage({super.key });
  @override
  State<EntrepreneurProfilePage> createState() => _EntrepreneurProfilePageState();
}

class _EntrepreneurProfilePageState extends State<EntrepreneurProfilePage> {
  UserProfile? userProfile ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () async {
      EasyLoading.show();
      await Provider.of<UserProvider>(context , listen: false).getUserData(FirebaseAuth.instance.currentUser?.uid??"");
      userProfile = Provider.of<UserProvider>(context , listen: false).userProfile ;
      EasyLoading.dismiss();
      setState(() {});
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return userProfile == null ? SizedBox() : Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              // ClipRRect(
              ClipOval(

                // borderRadius: BorderRadius.circular(75.0),
                child: Image.network(userProfile!.profileImage ??"" ,width: size_W(40)  , height: size_W(40) , fit: BoxFit.fill  ,  errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                  return Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" ,width: size_W(40)
                      , height: size_W(40));
                },),
              ),
              SizedBox(width: size_W(5),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome ${userProfile!.fillName}", style: ourTextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),

                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(userProfile!.bio??"" , style: ourTextStyle(fontSize: 15),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(userProfile!.email??"" , style: ourTextStyle(fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(userProfile!.phoneNumber??"" , style: ourTextStyle(fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(userProfile!.birthDate??"" , style: ourTextStyle(fontSize: 15),),
                    ),


                  ],
                ),
              ),

            ],
          ),
          SizedBox(width: size_H(20),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: (150),
                child: T9ButtonReverce(
                    onPressed: (){
                      Navigator.pushNamed(
                        context,
                        '/UpdateProfile',
                        arguments: userProfile,
                      ).then((value) async {
                        if(value != null){
                          EasyLoading.show();
                          await Provider.of<UserProvider>(context , listen: false).getUserData(userProfile?.userId??"");
                          userProfile = Provider.of<UserProvider>(context , listen: false).userProfile! ;
                          // myIdeas = await Provider.of<DataProvider>(context , listen: false).getUsersIdeas(userProfile!.userId??"") ;
                          setState(() {});
                          EasyLoading.dismiss();
                        }
                      });
                    },
                    textContent:"Edit Profile")),
          )
        ],
      ),
    );
  }
}
