import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/button.dart';
import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';

class InventorProfilePage extends StatefulWidget {
  InventorProfilePage({super.key });
  @override
  State<InventorProfilePage> createState() => _InventorProfilePageState();
}

class _InventorProfilePageState extends State<InventorProfilePage> {
  UserProfile? userProfile ;
  List<Idea>? myInvestmentIdeas  ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () async {
      EasyLoading.show();
      await Provider.of<UserProvider>(context , listen: false).getUserData(FirebaseAuth.instance.currentUser?.uid??"");
      userProfile = Provider.of<UserProvider>(context , listen: false).userProfile ;
      if(userProfile!.userId != null) {
        print("myInvestmentIdeas_ ${myInvestmentIdeas?.length}");
        myInvestmentIdeas = await Provider.of<DataProvider>(context , listen: false).getInvestmentIdeas(userProfile!.userId??"") ;
        print("myIdeas_ ${myInvestmentIdeas?.length}");
      }
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
