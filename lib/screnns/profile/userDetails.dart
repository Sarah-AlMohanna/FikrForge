import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key, required this.userProfile});
  final UserProfile? userProfile;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {

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
                              // Navigator.pushNamed(
                              //   context,
                              //   '/ideaDetails',
                              //   arguments: item,
                              // );
                            },
                            leading: Image.network("${item.image}"),
                            title: Text("${item.title}" , style: ourTextStyle(fontSize: 15 , fontWeight: FontWeight.w600),),
                            subtitle: Text("${item.description}" , style: ourTextStyle(),maxLines: 5,overflow: TextOverflow.ellipsis,),
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
}
