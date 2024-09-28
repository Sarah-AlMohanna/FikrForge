

import 'package:flutter/material.dart';

import '../configuration/theme.dart';

InkWell appBarNew({required BuildContext context,required String title}) {
  return InkWell(
    onTap: (){
      Navigator.of(context).pop();
    },
    child: Padding(
      padding: EdgeInsets.only(bottom: size_H(30) , top: size_H(50) , right: size_W(20) , left:  size_W(20)),
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios),
          Text("$title", style: ourTextStyle(fontSize: 15),)
        ],
      ),
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:forgeapp/configuration/theme.dart';
//
// import '../pages/meetings/addMeeting.dart';
// import '../pages/meetings/listMyMeeting.dart';
// import '../pages/meetings/listScheduleMeeting.dart';
// import 'customAppBar.dart';
// import 'customAppBarHomePage.dart';
//
// class CustomTabBar extends StatelessWidget {
//   final List<Tab> tabs;
//   final TabController controller;
//
//   CustomTabBar({
//     required this.tabs,
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TabBar(
//         controller: controller,
//         tabs: tabs,
//         labelColor: Colors.black,
//         labelStyle: ourTextStyle(),
//         unselectedLabelColor: Theme_Information.Primary_Color,
//         indicatorColor: Theme_Information.Second_Color,
//       ),
//     );
//   }
// }
//
// class ListAllMeeting extends StatefulWidget {
//   @override
//   _ListAllMeetingState createState() => _ListAllMeetingState();
// }
//
// class _ListAllMeetingState extends State<ListAllMeeting> with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: 1);
//     // _tabController = TabController(vsync: this, length: 2);
//   }
//
//   @override
//   void dispose() {
//     _tabController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButton: FloatingActionButton(
//       //   // label: const Text("Create New Meeting Schedule"),
//       //   onPressed: (){
//       //     /// NewMeeting
//       //     Navigator.push(context, MyCustomRoute(builder: (BuildContext context) => NewMeeting()));
//       //   },
//       //   backgroundColor: Theme_Information.Primary_Color,
//       //   child: Icon(Icons.add),
//       // ),
//       appBar: myAppBarHomePage(
//         title: "Meeting Planner Page".trn(),
//         actions: [
//           InkWell(
//             onTap: (){
//
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Theme_Information.Color_1
//                 ),
//                 width: 35,
//                 height: 35,child: Icon(Icons.add , color: Colors.black)
//                 ,),
//             ),
//           )
//         ]
//       ),
//       body: Column(
//         children: [
//           // CustomTabBar(
//           //   tabs: [
//           //     Tab(text: "My Meets".trn()),
//           //     // Tab(text: "Meets Requests".trn()),
//           //   ],
//           //   controller: _tabController!,
//           // ),
//           ///
//           // Expanded(child: TabBarView(
//           //     controller: _tabController,
//           //     children: [
//           //       ListMyMeeting(),
//           //       // ListScheduleMeeting(),
//           //       ///
//           //       // Container(
//           //       //   color: Colors.green[200],
//           //       //   child: Center(
//           //       //     child: Text("Meet Request".trn()),
//           //       //   ),
//           //       // ),
//           //     ],
//           //   ),
//           Expanded(child: ListMyMeeting()),
//           // ),
//         ],
//       ),
//     );
//   }
// }