import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/button.dart';
import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';

class UserDetailsAdminPage extends StatefulWidget {
  const UserDetailsAdminPage({super.key, required this.userProfile});
  final UserProfile? userProfile;

  @override
  State<UserDetailsAdminPage> createState() => _UserDetailsAdminPageState();
}

class _UserDetailsAdminPageState extends State<UserDetailsAdminPage> {

  List<Idea>? theIdeas  ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () async {
      if(widget.userProfile?.userId != null) {
        theIdeas = await Provider.of<DataProvider>(context , listen: false).getUsersIdeas(widget.userProfile?.userId??"") ;
        print("theIdeas_ ${theIdeas?.length}");
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
        title: Text("${widget.userProfile?.fillName??" - "}" , style: ourTextStyle(fontWeight: FontWeight.w600 , fontSize: 16 , color: Theme_Information.Color_1),),
        actions: [ Image.asset("assets/images/logo.png" , width:size_W(30),color: Theme_Information.Color_1,),],

      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // ClipRRect(
                      ClipOval(

                        // borderRadius: BorderRadius.circular(75.0),
                        child: Image.network(widget.userProfile!.profileImage ??"" ,width: size_W(40)  , height: size_W(40) , fit: BoxFit.fill  ,  errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                          return Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" ,width: size_W(40)
                              , height: size_W(40));
                        },),
                      ),
                      SizedBox(width: size_W(5),),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.userProfile!.fillName}", style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
                           if(widget.userProfile!.bio != null) Text(widget.userProfile!.bio??"" , style: ourTextStyle(),),
                            Text(widget.userProfile!.email??"" , style: ourTextStyle(),),
                            Text(widget.userProfile!.phoneNumber??"" , style: ourTextStyle(),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: (300),
                    child: T9ButtonReverce(
                      color: Theme_Information.Color_10,
                      onPressed: () async {
                        _showDeleteDialog(context);
                      },
                      textContent: "Delete User",
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(theIdeas != null)
                  Center(child: Align(alignment: Alignment.center, child:
                  Column(
                    children: List.generate(theIdeas!.length, (index) {
                      final item =  theIdeas![index];
                      return Card(
                          child: ListTile(
                            onTap: (){
                                Navigator.pushNamed(
                                  context,
                                  '/IdeaDetailsAdminPage',
                                  arguments: item,
                                ).then((value) async {
                                  if(value != null){
                                    theIdeas = await Provider.of<DataProvider>(context , listen: false).getUsersIdeas(widget.userProfile?.userId??"") ;
                                    setState(() {});
                                    print("theIdeas_ ${theIdeas?.length}");
                                  }
                                });
                            },
                            leading: Image.network("${item.image}" , width: size_W(25)
                              , height: size_W(25), errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                                return Image.asset("assets/images/logo.png" ,width: size_W(25)
                                    , height: size_W(25));
                              } ,),
                            title: Text("${item.title}" , style: ourTextStyle(fontSize: 15 , fontWeight: FontWeight.w600),),
                            subtitle: Text("${item.description}" , style: ourTextStyle(), maxLines:  2,overflow: TextOverflow.ellipsis,),
                            trailing: Text(item.status?.toUpperCase()??"" , style: ourTextStyle(),),
                          ));

                    }),
                  )
                  )),
                if(theIdeas == null)
                  Center(child: Text("There is no Data" , style: ourTextStyle(),)),
              ],
            ))
          ],
        ),
      ),
    );
  }



  Future<void> _showDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion', style: ourTextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
          content: Text('Are you sure you want to delete this user and all the ideas?' , style: ourTextStyle(),),
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
                if(widget.userProfile?.userId != null && widget.userProfile?.userId != ""){
                  EasyLoading.show();
                  // await FirebaseFirestore.instance.collection('user_ideas').doc(widget.item.idea_id).delete();
                  await Provider.of<DataProvider>(context , listen: false).deleteUserAndIdeas(widget.userProfile?.userId??"");
                  EasyLoading.showSuccess("The user deleted successfully");
                  Navigator.of(context).pop(true); // Close the dialog
                  Navigator.of(context).pop(true); // Close the dialog
                } else {
                  EasyLoading.showError("You cant delete this user");
                }
              },
            ),
          ],
        );
      },
    );
  }




}
