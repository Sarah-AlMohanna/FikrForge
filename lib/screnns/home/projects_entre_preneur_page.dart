import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../configuration/theme.dart';
import '../../models/IdeaModel.dart';
import '../../models/user_profile_model.dart';
import '../../provider/dataProvider.dart';
import '../../provider/user_provider.dart';

class EntrepreneurProjectsPage extends StatefulWidget {
  EntrepreneurProjectsPage({super.key});
  @override
  State<EntrepreneurProjectsPage> createState() => _EntrepreneurProjectsPageState();
}

class _EntrepreneurProjectsPageState extends State<EntrepreneurProjectsPage> {
  List<Idea>? myIdeas  ;
  UserProfile? userProfile ;
  String? selectedStatus;
  TextEditingController searchQueryController = TextEditingController();
  String searchQuery = "";
  final List<String> statusOptions = ['All', 'New', 'In progress', 'Completed'];
  String? selectedSort;
  final List<String> sortOptions = ['Sort by Name', 'Sort by Date', 'Sort by Amount', 'Sort by Progress'];
  String? selectedDisplay; // New variable for display type
  final List<String> displayOptions = [ 'Row' , 'Cards',]; // New display options



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 3), () async {
      EasyLoading.show();
      selectedStatus = statusOptions.first;
      selectedSort = sortOptions.first;
      selectedDisplay = displayOptions.first;
      await Provider.of<UserProvider>(context , listen: false).getUserData(FirebaseAuth.instance.currentUser?.uid??"");
      userProfile = Provider.of<UserProvider>(context , listen: false).userProfile ;
      if(userProfile!.userId != null) {
        print("myIdeas_ ${myIdeas?.length}");
        myIdeas = await Provider.of<DataProvider>(context , listen: false).getUsersIdeas(userProfile!.userId??"") ;
        print("myIdeas_ ${myIdeas?.length}");
      }
      EasyLoading.dismiss();
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {

    final filteredIdeas = myIdeas?.where((idea) {
      final matchesStatus = selectedStatus == null || selectedStatus == 'All' || idea.status == selectedStatus;
      final matchesSearch = idea.title?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
      return matchesStatus && matchesSearch;
    }).toList() ?? [];


    // Sort the filtered ideas based on the selected sort option
    if (selectedSort != null) {
      if (selectedSort == 'Sort by Name') {
        filteredIdeas.sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));
      } else if (selectedSort == 'Sort by Date') {
        filteredIdeas.sort((a, b) {
          DateTime? dateA = DateTime.tryParse((a).uploadedAt??"");
          DateTime? dateB = DateTime.tryParse((b).uploadedAt??"");
          if (dateA == null && dateB == null) return 0;
          if (dateA == null) return 1;
          if (dateB == null) return -1;
          return dateA.isBefore(dateB) ? -1 : 1;
        });
      } else if (selectedSort == 'Sort by Amount') {
        filteredIdeas.sort((a, b) {
          double amountA = double.tryParse((a as Idea).amount??"") ?? 0;
          double amountB = double.tryParse((b as Idea).amount??"") ?? 0;
          return amountA < amountB ? -1 : (amountA > amountB ? 1 : 0);
        });

      } else if (selectedSort == 'Sort by Progress') {
        filteredIdeas.sort((a, b) {
          double progressA = 0;
          double progressB = 0;
          if (a.budgetMaximum != null && a.amount != null) {
            progressA = (double.parse(a.amount ?? "0") / double.parse(a.budgetMaximum ?? "0")) * 100;
          }
          if (b.budgetMaximum != null && b.amount != null) {
            progressB = (double.parse(b.amount ?? "0") / double.parse(b.budgetMaximum ?? "0")) * 100;
          }
          return progressA.compareTo(progressB); // Sort by progress percentage
        });
      }
    }


    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: userProfile == null ? SizedBox() : Column(
        children: [
          /// status + search
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Project Status" , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
                    SizedBox(height: size_H(3),),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      hint: Text('Select a status'),
                      style: ourTextStyle(fontSize: 14 , color: Theme_Information.Color_5),
                      decoration:  InputDecoration(
                        // hintText: "Choose ${widget.title}",
                        hintStyle: ourTextStyle(fontSize: 14 , color: Theme_Information.Color_5),
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
                      items: statusOptions.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
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

            ],
          ),
          /// sorting + design
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sort by" , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
                    SizedBox(height: size_H(3),),
                    DropdownButtonFormField<String>(
                      value: selectedSort,
                      isExpanded: true,
                      style: ourTextStyle(fontSize: 14 , color: Theme_Information.Color_5),
                      decoration:  InputDecoration(
                        // hintText: "Choose ${widget.title}",
                        hintStyle: ourTextStyle(fontSize: 14 , color: Theme_Information.Color_5),
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
                      items: sortOptions.map((sort) {
                        return DropdownMenuItem<String>(
                          value: sort,
                          child: Text(sort),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSort = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: size_W(3),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("Display as" , style: ourTextStyle(fontSize: 16 , fontWeight: FontWeight.w600),),
                    SizedBox(height: size_H(3),),
                    DropdownButtonFormField<String>(
                      value: selectedDisplay,
                      hint: Text('Display as'),
                      isExpanded: true,
                      style: ourTextStyle(fontSize: 14 , color: Theme_Information.Color_5),

                      items: displayOptions.map((display) {
                        return DropdownMenuItem<String>(
                          value: display,
                          child: Text(display),
                        );
                      }).toList(),
                      decoration:  InputDecoration(
                        // hintText: "Choose ${widget.title}",
                        hintStyle: ourTextStyle(fontSize: 14 , color: Theme_Information.Color_5),
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
                          selectedDisplay = value;
                        });
                      },
                    ),

                  ],
                ),
              ),

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
                            "My Ideas",
                            style: ourTextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                              onTap: () async {
                                EasyLoading.show();
                                myIdeas = await Provider.of<DataProvider>(
                                        context,
                                        listen: false)
                                    .getUsersIdeas(userProfile!.userId ?? "");
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
                    if (myIdeas != null)
                      Expanded(
                        child: selectedDisplay == "Cards"
                            ? cardDisplay(filteredIdeas, context)
                            : rowDisplay(filteredIdeas, context),
                      ),
                    if (myIdeas == null)
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
        onTap: (){
          Navigator.pushNamed(
            context,
            '/ideaDetails',
            arguments: idea,
          );
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Image.network(
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
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        '/UpdateIdea',
                        arguments: idea,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(Icons.more_vert),
                    ),
                  ),
                ],
              ),
              Center(child: Text(idea.title ?? '' , style: ourTextStyle( fontSize: 16 , fontWeight: FontWeight.bold),)),
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


  Widget rowDisplay(List<Idea> filteredIdeas, BuildContext context) {
    return SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(filteredIdeas!.length, (index) {
          // children: List.generate(myIdeas!.length, (index) {
          final item =  filteredIdeas![index];
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
                  trailing: Text(item.status?.toUpperCase()??"" , style: ourTextStyle(),),

                ));
        }),
      ),
    );
  }



}
