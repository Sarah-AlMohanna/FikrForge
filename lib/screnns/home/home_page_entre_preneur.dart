import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/configuration/theme.dart';
import 'package:provider/provider.dart';

import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';

class HomePageEntrepreneur extends StatefulWidget {
  const HomePageEntrepreneur({super.key});

  @override
  State<HomePageEntrepreneur> createState() => _HomePageEntrepreneurState();
}

class _HomePageEntrepreneurState extends State<HomePageEntrepreneur> {

  UserProfile? userProfile ;
  List<Idea>? myIdeas  ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () async {


      userProfile = Provider.of<UserProvider>(context , listen: false).userProfile ;
      if(userProfile!.userId != null) {
        print("myIdeas_ ${myIdeas?.length}");
        myIdeas = await Provider.of<DataProvider>(context , listen: false).getUsersIdeas(userProfile!.userId??"") ;
        print("myIdeas_ ${myIdeas?.length}");
      }
      setState(() {});
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData( color: Theme_Information.Color_1),
        backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
        title: Text("Entrepreneur Account" , style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 16 , color: Theme_Information.Color_1),),
        actions: [ Image.asset("assets/images/logo.png" , width:size_W(30),color: Theme_Information.Color_1,),],

      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme_Information.Primary_Color,
        onPressed: (){
          Navigator.pushNamed(context, '/addIdea').then((value) async {
          if(value != null){
            EasyLoading.show();
            myIdeas = await Provider.of<DataProvider>(context , listen: false).getUsersIdeas(userProfile!.userId??"") ;
            setState(() {});
            EasyLoading.dismiss();
          }
          });
        },
        label: Text("Add Idea" , style: ourTextStyle(color: Theme_Information.Color_1 , fontSize: 16),),
        icon: Icon(Icons.add , color: Theme_Information.Color_1,),
      ),
      body: userProfile == null ?  SizedBox():
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(userProfile!.profileImage ??"" ,width: size_W(50)  , height: size_W(50)  ,  errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                    return Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" ,width: size_W(50)  , height: size_W(50));
                  },),
                ),
                SizedBox(width: size_W(5),),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome ${userProfile!.fillName}", style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),

                      Text(userProfile!.bio??"" , style: ourTextStyle(),),
                    ],
                  ),
                ),
                SizedBox(width: size_W(5),),
                InkWell(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        '/UpdateEntrepreneurProfile',
                        arguments: userProfile,
                      ).then((value) async {
                        if(value != null){
                          EasyLoading.show();
                          await Provider.of<UserProvider>(context , listen: false).getUserData(userProfile?.userId??"");
                          userProfile = Provider.of<UserProvider>(context , listen: false).userProfile ;
                          myIdeas = await Provider.of<DataProvider>(context , listen: false).getUsersIdeas(userProfile!.userId??"") ;
                          setState(() {});
                          EasyLoading.dismiss();
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.edit),
                    ))
              ],
            ),
            Divider(),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0 , bottom: 8.0),
                  child: Text("My Ideas" , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
                ),
                if(myIdeas != null)
                  Center(child: Align(alignment: Alignment.center, child:
                  Column(
                    children: List.generate(myIdeas!.length, (index) {
                      final item =  myIdeas![index];
                      return Card(
                          child: ListTile(
                            onTap: (){
                            //   ideaDetails
                              Navigator.pushNamed(
                                context,
                                '/ideaDetails',
                                arguments: item,
                              );
                            },
                              leading: Image.network("${item.image}"),
                              title: Text("${item.title}" , style: ourTextStyle(fontSize: 15 , fontWeight: FontWeight.w600),),
                              subtitle: Text("${item.description}" , style: ourTextStyle(),maxLines: 2,overflow: TextOverflow.ellipsis,),
                               trailing: Text(item.status?.toUpperCase()??"" , style: ourTextStyle(),),
                              
                          ));

                    }),
                  )
                  )),
                if(myIdeas == null)
                  Center(child: Text("There is no Data" , style: ourTextStyle(),)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
