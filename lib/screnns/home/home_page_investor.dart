import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/configuration/theme.dart';
import 'package:forgeapp/screnns/home/profile_inventor.dart';
import 'package:forgeapp/screnns/ideas/add_Idea.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/button.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';
import 'all_projects_page_inventor.dart';
import 'notificationsPage.dart';
import 'searchPage.dart';

class HomePageInvestor extends StatefulWidget {
  const HomePageInvestor({super.key});

  @override
  State<HomePageInvestor> createState() => _HomePageInvestorState();
}

class _HomePageInvestorState extends State<HomePageInvestor> {
  int pageSelected = 0 ;
  UserProfile? userProfile ;
  List<Idea>? myInvestmentIdeas  ;
  bool menuShown = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () async {


      userProfile = Provider.of<UserProvider>(context , listen: false).userProfile ;
      if(userProfile!.userId != null) {
        print("myInvestmentIdeas_ ${myInvestmentIdeas?.length}");
        myInvestmentIdeas = await Provider.of<DataProvider>(context , listen: false).getInvestmentIdeas(userProfile!.userId??"") ;
        print("myIdeas_ ${myInvestmentIdeas?.length}");
      }
      setState(() {});
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            setState(() {
              menuShown = !menuShown ;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.menu),
          ),
        ),
        iconTheme: IconThemeData( color: Theme_Information.Color_1),
        backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
        title: Text(titleAppbar() , style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 16 , color: Theme_Information.Color_1),),
        actions: [ Image.asset("assets/images/logo.png" , width:size_W(30),color: Theme_Information.Color_1,),],

      ),
        body: Container(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    if(menuShown)
                    Container(
                      width: 56,
                      color: Theme_Information.Primary_Color.withOpacity(0.8),
                      child: Column(
                        children: [
                          buildContainerIcon(IconData: Icons.home ,isSelected: pageSelected == 0 , onTap: (){
                            setState(() {
                              pageSelected = 0 ;
                            });
                          }),
                          buildContainerIcon(IconData: Icons.notifications ,isSelected: pageSelected == 1 , onTap: (){
                            setState(() {
                              pageSelected = 1 ;
                            });
                          }),
                          buildContainerIcon(IconData: Icons.search ,isSelected: pageSelected == 2 , onTap: (){
                            setState(() {
                              pageSelected = 2 ;
                            });
                          }),  buildContainerIcon(IconData: Icons.account_circle ,isSelected: pageSelected == 3 , onTap: (){
                            setState(() {
                              pageSelected = 3 ;
                            });
                          }),
                          buildContainerIcon(IconData: Icons.logout ,isSelected: pageSelected == 4 , onTap: (){
                            // setState(() {
                            //   pageSelected = 4 ;
                            // });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Logout Confirmation' , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
                                  content: Text('Are you sure you want to logout?' , style: ourTextStyle(),),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Dismiss the dialog
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Logout'),
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context, '/login');
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                          }),

                        ],
                      ),
                    ),
                    if(!menuShown)
                      SizedBox(width: 1,),
                    Expanded(flex: 10, child: buildProfilePage(context))
                  ],
                ),
              ));
  }

  String titleAppbar() {
    if(pageSelected == 0){
      return "Home page" ;
    } else if(pageSelected == 1){
      return "Notifications Page" ;
    } else if(pageSelected == 2){
      return "Search User" ;
    }  else if(pageSelected == 3){
      return "Profile Page" ;
    } else {
      return "";
    }

  }

  Widget buildProfilePage(BuildContext context){
    if(pageSelected == 0){
      return AllProjectsPageInventor();
    } else if(pageSelected == 1){
      return NotificationsPage();
    }else if(pageSelected == 2){
      return  SearchPage();
    } else if(pageSelected == 3){
      return InventorProfilePage();
    } else {
      return SizedBox();
    }

  }

  Widget buildContainerIcon({
    required IconData,
    required Function() onTap,
    required bool isSelected
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top:3.0 , bottom: 3),
        child: SizedBox(
            height: size_H(60),
            child: Icon(
              IconData,
              size: isSelected ? 25 : 20,
              color: isSelected ? Theme_Information.Color_1 : Theme_Information.Color_5,
            )),
      ),
    );
  }

  // Widget ProfilePage(BuildContext context) {
  //   return ;
  // }
}
