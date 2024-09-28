// // import 'package:crm/server/models/doctorAppointmentBooking.dart';
// import 'package:flutter/material.dart';
//
// import '../configuration/theme.dart';
// import '../model/meetingModel.dart';
//
// class MyMeetingPopupMenu extends StatelessWidget {
//   const MyMeetingPopupMenu({
//     Key? key,
//     required Meeting meeting,
//     required Function() viewFunction,
//     required Function() shareFunction,
//     required Function() editFunction,
//   })  :
//         _meeting = meeting,
//         _viewFunction = viewFunction,
//         _shareFunction = shareFunction,
//         _editFunction = editFunction,
//         super(key: key);
//
//   final Meeting _meeting;
//   final Function() _viewFunction ;
//   final Function() _shareFunction ;
//   final Function() _editFunction ;
//
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       elevation: 8,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       onSelected: (item) {
//         switch (item) {
//           case "edit":
//             {
//               // TODO accept the doctorAppointmentBooking
//               _editFunction();
//             }
//             break;
//           case "share":
//             {
//               // TODO decline the doctorAppointmentBooking
//               _shareFunction();
//             }
//             break;
//           case "view":
//             {
//               // Get.toNamed(Routes.BOOKING, arguments: _booking);
//               _viewFunction();
//             }
//             break;
//         }
//       },
//       itemBuilder: (context) {
//         var list = <PopupMenuEntry<Object>>[];
//         list.add(
//           PopupMenuItem(
//             child: Wrap(
//               crossAxisAlignment: WrapCrossAlignment.center,
//               spacing: 5,
//               children: [
//                 Icon(Icons.assignment_outlined, color: Theme_Information.Second_Color),
//                 Text(
//                   "View Details".trn(),
//                   style: ourTextStyle(),
//                 ),
//               ],
//             ),
//             value: "view",
//           ),
//         );
//         list.add(PopupMenuDivider(
//           height: 8,
//         ));
//         list.add(
//           PopupMenuItem(
//             child: Wrap(
//               crossAxisAlignment: WrapCrossAlignment.center,
//               spacing: 5,
//               children: [
//                 Icon(Icons.share, color: Theme_Information.Second_Color),
//                 Text(
//                   "Share".trn(),
//                   style: ourTextStyle(),
//                 ),
//               ],
//             ),
//             value: "share",
//           ),
//         );
//         list.add(
//           PopupMenuItem(
//             child: Wrap(
//               crossAxisAlignment: WrapCrossAlignment.center,
//               spacing: 5,
//               children: [
//                 Icon(Icons.edit  , color: Theme_Information.Second_Color),
//                 Text(
//                   "Edit".trn(),
//                   style: ourTextStyle(),
//                 ),
//               ],
//             ),
//             value: "edit",
//           ),
//         );
//         return list;
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Icon(
//           Icons.more_vert,
//           color: Theme_Information.Second_Color ,
//         ),
//       ),
//     );
//   }
// }
