import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forgeapp/screnns/admin/searchPageAdmin.dart';
import 'package:provider/provider.dart';

import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import 'allIdeaAdmin.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int pageSelected = 0 ;
  // UserProfile? userProfile ;
  List<Idea> allIdeas = []  ;
  List<Idea> lastIdeas = []  ;
  List<UserProfile> allUsers = []  ;
  bool menuShown = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () async {
      await Provider.of<DataProvider>(context, listen: false).getAllIdeas(allIdeas);
      await Provider.of<DataProvider>(context, listen: false).getUsersData(allUsers);
      print("allIdeas ${allIdeas!.length}");
      print("allUsers ${allUsers!.length}");

      lastIdeas = allIdeas.take(6).toList();
      lastIdeas.sort((a, b) {

        DateTime? dateA = parseFirebaseTimestamp(a.uploadedAt??"");
        // DateTime? dateA = DateTime.tryParse((a).uploadedAt??"");
        DateTime? dateB = parseFirebaseTimestamp(b.uploadedAt??"");
        // DateTime? dateB = DateTime.tryParse((b).uploadedAt??"");

        // print("ss_a_ ${dateA}");
        // print("ss_b_ ${dateB}");

        if (dateA == null && dateB == null) return 0;
        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateA.isBefore(dateB) ? 1 : -1;
        // return dateA.isBefore(dateB) ? -1 : 1;
      });





      setState(() {});
    });

  }
  DateTime parseFirebaseTimestamp(String timestampString) {
    // Regular expression to extract the seconds and nanoseconds values
    final regex = RegExp(r'Timestamp\(seconds=(\d+), nanoseconds=(\d+)\)');
    final match = regex.firstMatch(timestampString);

    if (match != null) {
      int seconds = int.parse(match.group(1)!);
      int nanoseconds = int.parse(match.group(2)!);

      // Convert seconds to DateTime
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: true);

      // Adjust for nanoseconds
      DateTime adjustedDateTime = dateTime.add(Duration(milliseconds: nanoseconds ~/ 1000000));

      return adjustedDateTime;
    } else {
      throw FormatException('Invalid Firebase Timestamp string');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              setState(() {
                menuShown = !menuShown;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.menu),
            ),
          ),
          iconTheme: IconThemeData(color: Theme_Information.Color_1),
          backgroundColor: Theme_Information.Primary_Color.withOpacity(0.8),
          title: Text(
            titleAppbar(),
            style: ourTextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Theme_Information.Color_1),
          ),
          actions: [
            Image.asset(
              "assets/images/logo.png",
              width: size_W(30),
              color: Theme_Information.Color_1,
            ),
          ],
        ),

        body: Row(
          children: [
            if (menuShown)
              Container(
                width: 56,
                color: Theme_Information.Primary_Color.withOpacity(0.8),
                child: Column(
                  children: [
                    buildContainerIcon(
                        IconData: Icons.home,
                        isSelected: pageSelected == 0,
                        onTap: () {
                          setState(() {
                            pageSelected = 0;
                          });
                        }),
                    buildContainerIcon(
                        IconData: Icons.account_circle,
                        isSelected: pageSelected == 1,
                        onTap: () {
                          setState(() {
                            pageSelected = 1;
                          });
                        }),
                    buildContainerIcon(
                        IconData: Icons.insert_drive_file,
                        isSelected: pageSelected == 2,
                        onTap: () {
                          setState(() {
                            pageSelected = 2;
                          });
                        }),
                    buildContainerIcon(
                        IconData: Icons.logout,
                        isSelected: pageSelected == 4,
                        onTap: () {
                          // setState(() {
                          //   pageSelected = 4 ;
                          // });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Logout Confirmation',
                                  style: ourTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  'Are you sure you want to logout?',
                                  style: ourTextStyle(),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Dismiss the dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Logout'),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
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
            if (!menuShown)
              SizedBox(
                width: 1,
              ),
            Expanded(flex: 10, child: buildProfilePage(context))
          ],
        ));
  }

  String titleAppbar() {
    if (pageSelected == 0) {
      return "Admin Home page";
    } else if (pageSelected == 1) {
      return "All Users";
    } else if (pageSelected == 2) {
      return "All Ideas";
    } else {
      return "";
    }
  }

  Widget buildProfilePage(BuildContext context){
    if(pageSelected == 0){
      return homeIndex();
      // return AllProjectsPageInventor();
    } else if(pageSelected == 1){
      return SearchPageADMIN();
      // return NotificationsPage();
    }else if(pageSelected == 2){
      return  AllIdeaAdmin();
      // return  SearchPage();
    } else {
      return SizedBox();
    }

  }

  Column homeIndex() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: InkWell(
              onTap: (){
                setState(() {
                  pageSelected = 1 ;
                });
              },
              child: Card(child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(child: Column(
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(height: size_H(5),),
                    Text("${allUsers?.length??" - "} Users"),
                  ],
                )),
              ),),
            )),
            Expanded(child: InkWell(
              onTap: (){
                setState(() {
                  pageSelected = 2 ;
                });
              },
              child: Card(child: Center(child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Icon(Icons.wb_iridescent_rounded),
                    SizedBox(height: size_H(5),),
                    Text("${allIdeas?.length??" - "} Ideas"),
                  ],
                ),
              )),),
            )),
          ],
        ),

        Row(
          children: [
            Expanded(child: Card(child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(child: Column(
                children: [
                  Text("${allUsers.where((user) => user.accountType == 'entrepreneur').length??" - "} Entrepreneur Users"),
                ],
              )),
            ),)),
            Expanded(child: Card(child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(child: Column(
                children: [
                  Text("${allUsers.where((user) => user.accountType == 'investor').length??" - "} Investor Users"),
                ],
              )),
            ),)),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Last Ideas" , style: ourTextStyle(fontSize: 18 , fontWeight: FontWeight.w800),),
        ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
          
              children: List.generate(
                (lastIdeas.length / 2).ceil(), // Number of rows
                    (rowIndex) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align cards evenly
                    children: [
                      cardItem(lastIdeas[rowIndex * 2]),
                      if (rowIndex * 2 + 1 < lastIdeas.length)
                        cardItem(lastIdeas[rowIndex * 2 + 1]),
                      // Second card
                    ],
                  );
                },
              ),
            ),
          ),
        )
        
      ],
    );
  }


  Expanded cardItem(Idea idea) {
    double percentage = 0;
    if (idea.budgetMaximum != null && idea.amount != null) {
      percentage = (double.parse(idea.amount??"0") / double.parse(idea.budgetMaximum??"0")) * 100; // Calculate percentage
    }
    return Expanded(
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(
            context,
            '/IdeaDetailsAdminPage',
            arguments: idea,
          );
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  "${idea.image}",
                  width: size_W(40),
                  height: size_W(40),
                  errorBuilder: (context, exception, stackTrace) {
                    return Image.asset(
                      "assets/images/logo.png",
                      width: size_W(40),
                      height: size_W(40),
                    );
                  },
                ),
              ),
              Center(child: Text(idea.title ?? '' , style: ourTextStyle( fontSize: 16 , fontWeight: FontWeight.bold),)),
              SizedBox(height: size_H(5),),
              Center(child: Text('Uploaded at : ${parseFirebaseTimestamp((idea).uploadedAt??"")}' , style: ourTextStyle( fontSize: 13 , fontWeight: FontWeight.bold),)),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Tracking Amount ${idea.amount??" - "} / ${idea.budgetMaximum??" - "}",
                  style: ourTextStyle(fontSize: 14,),
                ),
              ),
              if (idea.budgetMaximum != null && idea.amount != null)
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      // Background color for the progress bar
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: percentage / 100, // Fill based on percentage
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: percentage == 100
                              ? Theme_Information.Primary_Color
                              : Theme_Information.Primary_Color,
                          // Change color based on percentage
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),

              SizedBox(height: size_H(10),)
            ],
          ),
        ),
      ),
    );
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

}
