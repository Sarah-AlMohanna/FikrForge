import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../commenwidget/button.dart';
import '../../commenwidget/investWidget.dart';
import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';

class AllProjectsPageInventor extends StatefulWidget {
  const AllProjectsPageInventor({super.key});

  @override
  State<AllProjectsPageInventor> createState() => _AllProjectsPageInventorState();
}

class _AllProjectsPageInventorState extends State<AllProjectsPageInventor> {
  UserProfile? userProfile ;
  List<Idea>? allIdeas  ;
  List<Idea>? allIdeasToInvest  ;
  List<Idea>? myInvestmentIdeas  ;

  TextEditingController searchQueryController = TextEditingController();
  String searchQuery = "";



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
        allIdeas = await Provider.of<DataProvider>(context , listen: false).getAllIdeasToInvest(userProfile!.userId??"")??[] ;
        myInvestmentIdeas = await Provider.of<DataProvider>(context , listen: false).getInvestmentIdeas(userProfile!.userId??"")??[] ;
        allIdeasToInvest = [];
        // allIdeas!.forEach((element) async {
        //   bool isInvest =
        //       await Provider.of<DataProvider>(context, listen: false)
        //               .getIsInvest(element) ??
        //           false;
        //   print("isInvest ${isInvest}");
        //   if (!isInvest) {
        //     allIdeasToInvest!.add(element);
        //   }
        // });
        final List<Future<void>> futures = allIdeas!.map((element) async {
          bool isInvest = await Provider.of<DataProvider>(context, listen: false)
              .getIsInvest(element) ?? false;
          print("isInvest $isInvest");
          if (!isInvest) {
            allIdeasToInvest!.add(element);
          }
        }).toList();
        await Future.wait(futures);

        setState(() {});
        print("myIdeas_ ${myInvestmentIdeas?.length}");
      }
      EasyLoading.dismiss();
      setState(() {});
    });

  }
  @override
  Widget build(BuildContext context) {

    final filteredIdeas = allIdeasToInvest?.where((idea) {
      final matchesSearch = idea.title?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
      return matchesSearch;
    }).toList() ?? [];



    return userProfile == null ? SizedBox() : Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: size_W(3),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("Search" , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
                    SizedBox(height: size_H(3),),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: searchQueryController,
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(),
                              //   prefixIcon: Icon(Icons.search),
                              // ),

                              decoration:  InputDecoration(
                                // hintText: "Choose ${widget.title}",
                                hintStyle: ourTextStyle(fontSize: 14 , color: Theme_Information.Color_7),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                  const BorderSide(color: Colors.transparent, width: 0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                  const BorderSide(color: Colors.transparent, width: 0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                  const BorderSide(color: Colors.transparent, width: 0),
                                ),
                                errorStyle: ourTextStyle(color: Theme_Information.Color_10 , fontSize: 10),
                                border: InputBorder.none, // Removes the default underline
                                fillColor: Theme_Information.Color_9,
                                filled: true,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: size_W(3),),
                        InkWell(
                          onTap: (){
                            setState(() {
                              searchQuery = '';
                              searchQueryController.clear();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.clear),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(width: size_W(3),),

            ],
          ),
                Divider(),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Invest in the ideas",
                            style: ourTextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                              onTap: () async {
                                Future.delayed(const Duration(microseconds: 3), () async {
                                  EasyLoading.show();
                                  await Provider.of<UserProvider>(context , listen: false).getUserData(FirebaseAuth.instance.currentUser?.uid??"");
                                  userProfile = Provider.of<UserProvider>(context , listen: false).userProfile ;
                                  if(userProfile!.userId != null) {
                                    print("myInvestmentIdeas_ ${myInvestmentIdeas?.length}");
                                    allIdeas = await Provider.of<DataProvider>(context , listen: false).getAllIdeasToInvest(userProfile!.userId??"")??[] ;
                                    myInvestmentIdeas = await Provider.of<DataProvider>(context , listen: false).getInvestmentIdeas(userProfile!.userId??"")??[] ;
                                    allIdeasToInvest = [];
                                    // allIdeas!.forEach((element) async {
                                    //   bool isInvest =
                                    //       await Provider.of<DataProvider>(context, listen: false)
                                    //               .getIsInvest(element) ??
                                    //           false;
                                    //   print("isInvest ${isInvest}");
                                    //   if (!isInvest) {
                                    //     allIdeasToInvest!.add(element);
                                    //   }
                                    // });
                                    final List<Future<void>> futures = allIdeas!.map((element) async {
                                      bool isInvest = await Provider.of<DataProvider>(context, listen: false)
                                          .getIsInvest(element) ?? false;
                                      print("isInvest $isInvest");
                                      if (!isInvest) {
                                        allIdeasToInvest!.add(element);
                                      }
                                    }).toList();
                                    await Future.wait(futures);

                                    setState(() {});
                                    print("myIdeas_ ${myInvestmentIdeas?.length}");
                                  }
                                  EasyLoading.dismiss();
                                  setState(() {});
                                });

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.refresh),
                              ))
                        ],
                      ),
                    ),
                    if (filteredIdeas.isNotEmpty)
                      Expanded(child: cardDisplay(filteredIdeas, context)),


                    if (filteredIdeas.isEmpty)
                      Center(
                          child: Text(
                        "There is no Data",
                        style: ourTextStyle(),
                      )),
                  ],
                ))
              ],
            ),
          );
  }

  Widget cardDisplay(List<Idea> filteredIdeas, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: List.generate(
          (filteredIdeas.length / 2).ceil(), // Number of rows
              (rowIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align cards evenly
              children: [
                cardItem(filteredIdeas[rowIndex * 2]),
                if (rowIndex * 2 + 1 < filteredIdeas.length)
                  cardItem(filteredIdeas[rowIndex * 2 + 1]),
                // Second card
              ],
            );
          },
        ),
      ),
    );
  }

  Expanded cardItem(Idea idea) {
    double percentage = 0;
    if (idea.budgetMaximum != null && idea.amount != null) {
      percentage = (double.parse(idea.amount??"0") / double.parse(idea.budgetMaximum??"0")) * 100; // Calculate percentage
    }
    return Expanded(
      child: InkWell(
        onTap: () async {
          Navigator.pushNamed(
            context,
            '/IdeaDetailsInvestorPage',
            arguments: idea,
          );
        ///
        //     print("all Idea = ${allIdeas?.length}");
        //     allIdeas!.forEach((element) async {
        //       await Provider.of<DataProvider>(context, listen: false).changeIdeaStatus(element );
        //     });

        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size_H(5),),
              Center(
                child: Image.network(
                  "${idea.image}",
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: size_W(50),
                  errorBuilder: (context, exception, stackTrace) {
                    return Image.asset(
                      "assets/images/logo.png",
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: size_W(50),
                    );
                  },
                ),
              ),
              SizedBox(height: size_H(5),),
              Center(child: Text(idea.title ?? '' , style: ourTextStyle( fontSize: 16 , fontWeight: FontWeight.bold),)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8 , top: 3 , bottom: 3),
                child: Divider(),
              ),

              Container(
                  height: size_H(50),
                  child: Text(idea.description ?? '' , style: ourTextStyle( fontSize: 13 ),)),
              SizedBox(height: size_H(10),),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(
                    context,
                    '/IdeaMoreDetailsPage',
                    arguments: idea,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Show More" , style: ourTextStyle( fontSize: 13 , fontWeight: FontWeight.bold ),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8 , top: 3 , bottom: 3),
                child: Divider(),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0),
                child: PaymentSelector(item: idea,isThereOther: false, callBack: (){
                  Future.delayed(const Duration(microseconds: 3), () async {
                    EasyLoading.show();
                    await Provider.of<UserProvider>(context , listen: false).getUserData(FirebaseAuth.instance.currentUser?.uid??"");
                    userProfile = Provider.of<UserProvider>(context , listen: false).userProfile ;
                    if(userProfile!.userId != null) {
                      print("myInvestmentIdeas_ ${myInvestmentIdeas?.length}");
                      allIdeas = await Provider.of<DataProvider>(context , listen: false).getAllIdeasToInvest(userProfile!.userId??"")??[] ;
                      myInvestmentIdeas = await Provider.of<DataProvider>(context , listen: false).getInvestmentIdeas(userProfile!.userId??"")??[] ;
                      allIdeasToInvest = [];
                      // allIdeas!.forEach((element) async {
                      //   bool isInvest =
                      //       await Provider.of<DataProvider>(context, listen: false)
                      //               .getIsInvest(element) ??
                      //           false;
                      //   print("isInvest ${isInvest}");
                      //   if (!isInvest) {
                      //     allIdeasToInvest!.add(element);
                      //   }
                      // });
                      final List<Future<void>> futures = allIdeas!.map((element) async {
                        bool isInvest = await Provider.of<DataProvider>(context, listen: false)
                            .getIsInvest(element) ?? false;
                        print("isInvest $isInvest");
                        if (!isInvest) {
                          allIdeasToInvest!.add(element);
                        }
                      }).toList();
                      await Future.wait(futures);

                      setState(() {});
                      print("myIdeas_ ${myInvestmentIdeas?.length}");
                    }
                    EasyLoading.dismiss();
                    setState(() {});
                  });
                },),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8 , top: 3 , bottom: 3),
                child: Divider(),
              ),
              ///
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     "Tracking Amount ${idea.amount??" - "} / ${idea.budgetMaximum??" - "}",
              //     style: ourTextStyle(fontSize: 14,),
              //   ),
              // ),
              ///
              if (idea.budgetMaximum != null && idea.amount != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
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
                    SizedBox(width: size_W(10),),
                       Text(
                        "${idea.budgetMaximum??" - "} SAR",
                        style: ourTextStyle(fontSize: 14,),
                      ),
                  ],
                ),


              SizedBox(height: size_H(10),)
            ],
          ),
        ),
      ),
    );
  }

  ///
  // Center rowItem(List<Idea> filteredIdeas, BuildContext context) {
  //   return Center(child: Align(alignment: Alignment.center, child:
  //             SingleChildScrollView(
  //               child: Column(
  //                 children: List.generate(filteredIdeas!.length, (index) {
  //                   final idea =  filteredIdeas![index];
  //                   return InkWell(
  //                     onTap: (){
  //                       Navigator.pushNamed(
  //                         context,
  //                         '/ideaDetails',
  //                         arguments: idea,
  //                       );
  //                     },
  //                     child: Card(
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Row(
  //                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //
  //                             children: [
  //                               Image.network(
  //                                 "${idea.image}",
  //                                 width: size_W(40),
  //                                 height: size_W(40),
  //                                 errorBuilder: (context, exception, stackTrace) {
  //                                   return Image.asset(
  //                                     "assets/images/logo.png",
  //                                     width: size_W(40),
  //                                     height: size_W(40),
  //                                   );
  //                                 },
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 child: Row(
  //                                   children: [
  //                                     Text(idea.title ?? '' , style: ourTextStyle( fontSize: 16 , fontWeight: FontWeight.bold),),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Divider(),
  //                           ),
  //
  //
  //                           SizedBox(height: size_H(10),)
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //
  //                 }),
  //               ),
  //             )
  //             ));
  // }
  ///
}
