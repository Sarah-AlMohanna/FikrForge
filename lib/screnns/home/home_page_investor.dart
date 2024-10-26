import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:forgeapp/configuration/theme.dart';
import 'package:forgeapp/screnns/ideas/add_Idea.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/button.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';
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
        iconTheme: IconThemeData( color: Theme_Information.Color_1),
        backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
        title: Text(titleAppbar() , style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 16 , color: Theme_Information.Color_1),),
        actions: [ Image.asset("assets/images/logo.png" , width:size_W(30),color: Theme_Information.Color_1,),],

      ),
        body: Container(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
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
    } else {
      return "";
    }

  }

  Widget buildProfilePage(BuildContext context){
    if(pageSelected == 0){
      return userProfile == null
          ? SizedBox()
          : ProfilePage(context);
    }
    else if(pageSelected == 1){
      return NotificationsPage();
    }else if(pageSelected == 2){
      return userProfile == null
          ? SizedBox()
          : SearchPage();
    }     else {
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

  Widget ProfilePage(BuildContext context) {
    return Padding(
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
                    Text("Welcome ${userProfile!.fillName}", style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),

                    Text(userProfile!.bio??"" , style: ourTextStyle(),),
                  ],
                ),
              ),
              SizedBox(width: size_W(5),),
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
                          userProfile = Provider.of<UserProvider>(context , listen: false).userProfile ;
                          myInvestmentIdeas = await Provider.of<DataProvider>(context , listen: false).getInvestmentIdeas(userProfile!.userId??"") ;
                          setState(() {});
                          EasyLoading.dismiss();
                        }
                      });
                    },
                      textContent:"Edit Profile")),
              )
            ],
          ),
          Divider(),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0 , bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Investments" , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
                    InkWell(
                        onTap: () async {
                            EasyLoading.show();
                            myInvestmentIdeas = await Provider.of<DataProvider>(context , listen: false).getInvestmentIdeas(userProfile!.userId??"") ;
                            setState(() {});
                            EasyLoading.dismiss();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.refresh),
                        ))
                  ],
                ),
              ),
              if(myInvestmentIdeas != null)
                Center(child: Align(alignment: Alignment.center, child:
                Column(
                  children: List.generate(myInvestmentIdeas!.length, (index) {
                    final item =  myInvestmentIdeas![index];
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
                            leading: Image.network("${item.image}" , width: size_W(25)
                          , height: size_W(25), errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                              return Image.asset("assets/images/logo.png" ,width: size_W(25)
                                  , height: size_W(25));
                            } ,),
                            title: Text("${item.title}" , style: ourTextStyle(fontSize: 15 , fontWeight: FontWeight.w600),),
                            subtitle: Text("${item.description}" , style: ourTextStyle(),maxLines: 2,overflow: TextOverflow.ellipsis,),
                             // trailing: Text(item.status?.toUpperCase()??"" , style: ourTextStyle(),),

                        ));

                  }),
                )
                )),
              if(myInvestmentIdeas == null)
                Center(child: Text("There is no Data" , style: ourTextStyle(),)),
            ],
          ))
        ],
      ),
    );
  }
}
