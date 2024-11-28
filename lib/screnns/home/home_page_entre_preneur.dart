import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/configuration/theme.dart';
import 'package:forgeapp/screnns/home/profile_entre_preneur.dart';
import 'package:forgeapp/screnns/home/projects_entre_preneur_page.dart';
import 'package:forgeapp/screnns/ideas/add_Idea.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/button.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';
import 'notificationsPage.dart';
import 'searchPage.dart';

class HomePageEntrepreneur extends StatefulWidget {
  const HomePageEntrepreneur({super.key});

  @override
  State<HomePageEntrepreneur> createState() => _HomePageEntrepreneurState();
}

class _HomePageEntrepreneurState extends State<HomePageEntrepreneur> {
  int pageSelected = 0 ;
  bool menuShown = false ;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData( color: Theme_Information.Color_1),
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
        backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
        title: Text(titleAppbar() , style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 16 , color: Theme_Information.Color_1),),
        actions: [
          // Image.asset("assets/images/logo.png" , width:size_W(30),color: Theme_Information.Color_1,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildContainerIcon(IconData: Icons.notifications ,isSelected: true  ,size: 30, onTap: (){
              setState(() {
                pageSelected = 1 ;
              });
            }),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildContainerIcon(IconData: Icons.account_circle ,isSelected: true ,size: 30, onTap: (){
              setState(() {
                pageSelected = 4 ;
              });
            }),
          ),
        ],

      ),
      ///
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Theme_Information.Primary_Color,
      //   onPressed: (){
      //     Navigator.pushNamed(context, '/addIdea').then((value) async {
      //     if(value != null){
      //       EasyLoading.show();
      //       myIdeas = await Provider.of<DataProvider>(context , listen: false).getUsersIdeas(userProfile!.userId??"") ;
      //       setState(() {});
      //       EasyLoading.dismiss();
      //     }
      //     });
      //   },
      //   label: Text("Add Idea" , style: ourTextStyle(color: Theme_Information.Color_1 , fontSize: 16),),
      //   icon: Icon(Icons.add , color: Theme_Information.Color_1,),
      // ),
      ///
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
                          }),
                          buildContainerIcon(IconData: Icons.add ,isSelected: pageSelected == 3 , onTap: (){
                            setState(() {
                              pageSelected = 3 ;
                            });
                          }),
                          buildContainerIcon(IconData: Icons.account_circle ,isSelected: pageSelected == 4 , onTap: (){
                            setState(() {
                              pageSelected = 4 ;
                            });
                          }),
                          buildContainerIcon(IconData: Icons.logout ,isSelected: pageSelected == 5 , onTap: (){
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
      return "My Projects" ;
    } else if(pageSelected == 1){
      return "Notification Page" ;
    } else if(pageSelected == 2){
      return "Search User" ;
    } else if(pageSelected == 3){
      return "Add your Idea" ;
    } else if(pageSelected == 4){
      return "Profile Page" ;
    } else {
      return "";
    }

  }

  Widget buildProfilePage(BuildContext context){
    if(pageSelected == 0){
      return EntrepreneurProjectsPage();
    }
    else if(pageSelected == 1){
      return NotificationsPage();
    }
    else if(pageSelected == 2){
      return SearchPage();
    } else if(pageSelected == 3){
      return AddIdeaPage(backToHome: (){
       setState(() {
         pageSelected == 0 ;
       });
      });
    } else if(pageSelected == 4){
      return  EntrepreneurProfilePage();
    }
    else {
      return SizedBox();
    }
  }

  Widget buildContainerIcon({
    required IconData,
    required Function() onTap,
    required bool isSelected,
    double? size
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
              size: size ?? (isSelected ? 25 : 20),
              color: isSelected ? Theme_Information.Color_1 : Theme_Information.Color_5,
            )),
      ),
    );
  }

  // Widget EntrepreneurProjectsPage(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(15.0),
  //     child: Column(
  //       children: [
  //        SizedBox(height: 1,),
  //         Divider(),
  //         Expanded(child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 8.0 , bottom: 8.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text("My Ideas" , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
  //                   InkWell(
  //                       onTap: () async {
  //                           EasyLoading.show();
  //                           myIdeas = await Provider.of<DataProvider>(context , listen: false).getUsersIdeas(userProfile!.userId??"") ;
  //                           setState(() {});
  //                           EasyLoading.dismiss();
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Icon(Icons.refresh),
  //                       ))
  //                 ],
  //               ),
  //             ),
  //             if(myIdeas != null)
  //               Center(child: Align(alignment: Alignment.center, child:
  //               Column(
  //                 children: List.generate(myIdeas!.length, (index) {
  //                   final item =  myIdeas![index];
  //                   return Card(
  //                       child: ListTile(
  //                         onTap: (){
  //                         //   ideaDetails
  //                           Navigator.pushNamed(
  //                             context,
  //                             '/ideaDetails',
  //                             arguments: item,
  //                           );
  //                         },
  //                           leading: Image.network("${item.image}" , width: size_W(25)
  //                         , height: size_W(25), errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
  //                             return Image.asset("assets/images/logo.png" ,width: size_W(25)
  //                                 , height: size_W(25));
  //                           } ,),
  //                           title: Text("${item.title}" , style: ourTextStyle(fontSize: 15 , fontWeight: FontWeight.w600),),
  //                           subtitle: Text("${item.description}" , style: ourTextStyle(),maxLines: 2,overflow: TextOverflow.ellipsis,),
  //                            trailing: Text(item.status?.toUpperCase()??"" , style: ourTextStyle(),),
  //
  //                       ));
  //
  //                 }),
  //               )
  //               )),
  //             if(myIdeas == null)
  //               Center(child: Text("There is no Data" , style: ourTextStyle(),)),
  //           ],
  //         ))
  //       ],
  //     ),
  //   );
  // }
}
