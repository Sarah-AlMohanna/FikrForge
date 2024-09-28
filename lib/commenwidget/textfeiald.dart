// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// Widget T9EditTextStyle(
//     var hintText, TextEditingController textEditingController, {IconData? iconData ,TextInputType textInputType = TextInputType.text}) {
//   return Padding(
//     padding:  EdgeInsets.only(right: (20), left: (20)),
//     child: Container(
//       // decoration: boxDecoration(radius: 40, showShadow: true, bgColor: Colors.white),
//       child: TextFormField(
//
//         // style: TextStyle(fontSize: textSizeMedium, ),
//         style: ourTextStyle(fontSize: 15, ),
//         controller: textEditingController,
//         keyboardType: textInputType,
//         textInputAction: TextInputAction.next,
//         /*
//         decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Write your Problem here',
//                         labelStyle: ourTextStyle(
//                           color: Colors.grey,
//                           fontSize: 14.0,
//                           // textAlign: TextAlign.center,
//                         ),
//                       ),
//          */
//         decoration: InputDecoration(
//           fillColor: Colors.grey.withOpacity(0.2),
//           border: OutlineInputBorder(),
//           prefixIcon: iconData != null ? Icon(iconData) : null,
//           labelStyle: ourTextStyle(),
//           labelText: hintText,
//           // labelStyle: TextStyle(
//           //   color: Colors.grey,
//           //   fontSize: 14.0,
//           //   // textAlign: TextAlign.center,
//           // ),
//           // contentPadding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//           contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
//           // hintText: hintText,
//           filled: true,
//           // fillColor: Theme_Information.Icon_Back_Color,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:  const BorderSide(color: Colors.white, width: 0.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:  const BorderSide(color: Colors.white, width: 0.0),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
//
// Widget T9EditTextStyleWithoutPadding(
//     var hintText, TextEditingController textEditingController, {IconData? iconData ,TextInputType textInputType = TextInputType.text}) {
//   return Container(
//     // decoration: boxDecoration(radius: 40, showShadow: true, bgColor: Colors.white),
//     child: TextFormField(
//
//       // style: TextStyle(fontSize: textSizeMedium, ),
//       style: ourTextStyle(fontSize: 15, ),
//       controller: textEditingController,
//       keyboardType: textInputType,
//       textInputAction: TextInputAction.next,
//       /*
//       decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Write your Problem here',
//                       labelStyle: ourTextStyle(
//                         color: Colors.grey,
//                         fontSize: 14.0,
//                         // textAlign: TextAlign.center,
//                       ),
//                     ),
//        */
//       decoration: InputDecoration(
//         fillColor: Colors.white,
//         border: OutlineInputBorder(),
//         prefixIcon: iconData != null ? Icon(iconData) : null,
//         labelStyle: ourTextStyle(),
//         labelText: hintText,
//         // labelStyle: TextStyle(
//         //   color: Colors.grey,
//         //   fontSize: 14.0,
//         //   // textAlign: TextAlign.center,
//         // ),
//         // contentPadding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//         contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
//         // hintText: hintText,
//         filled: true,
//         // fillColor: Theme_Information.Icon_Back_Color,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide:  const BorderSide(color: Colors.white, width: 0.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide:  const BorderSide(color: Colors.white, width: 0.0),
//         ),
//       ),
//     ),
//   );
// }
//
//
//
//
// Widget T9EditTextStylePassword(
//     var hintText, TextEditingController textEditingController, {IconData iconData = Icons.password_rounded ,  TextInputType textInputType = TextInputType.text,
//       isHidden = false , Function()? function }) {
//   return Padding(
//     padding:  EdgeInsets.only(right: (20), left: (20)),
//     child: Container(
//       // color: Colors.white,
//       // decoration: boxDecoration(radius: 40, showShadow: true, bgColor: Colors.white),
//       child: TextFormField(
//         style: ourTextStyle(fontSize: 15, ),
//         obscureText: isHidden,
//         controller: textEditingController,
//         keyboardType: textInputType,
//         textInputAction: TextInputAction.next,
//         decoration: InputDecoration(
//           fillColor: Colors.grey.withOpacity(0.2),
//           // prefixIcon: Icon(iconData),
//           suffixIcon: isHidden != null ?
//           InkWell(
//
//
//
//               onTap: function,
//               child: isHidden ? Icon(Icons.remove_red_eye_outlined ,  color: Primary_Color) : Icon(Icons.remove_red_eye , color: Primary_Color,)) : null,
//           contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
//           labelText: hintText,
//           filled: true,
//           labelStyle: ourTextStyle(),
//           // fillColor: Theme_Information.Icon_Back_Color,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:  const BorderSide(color: Colors.white, width: 0.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:  const BorderSide(color: Colors.white, width: 0.0),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// final Primary_Color =      Color(0xff1c0fb8) ;
//
// TextStyle ourTextStyleEnglish({Color? color, double? fontSize ,FontWeight?  fontWeight }){
//   // color ??= Primary_Color;
//   color ??= Colors.black;
//   fontSize ??= 13;
//   fontWeight ??= FontWeight.normal;
//   return GoogleFonts.poppins(color:  color ,fontWeight:  fontWeight, fontSize:  (fontSize));
//   // return GoogleFonts.aBeeZee(color:  color ,fontWeight:  fontWeight, fontSize:  size_H(fontSize));
// }
//
// TextStyle ourTextStyle({Color? color, double? fontSize ,FontWeight?  fontWeight ,double?  height ,TextDecoration? decoration }){
//   // color ??= Primary_Color; ///  decoration: TextDecoration.underline,
//   color ??= Colors.black;
//   fontSize ??= 13;
//   fontWeight ??= FontWeight.normal;
//
//     return GoogleFonts.poppins(color:  color ,fontWeight:  fontWeight,height: height, fontSize:  (fontSize) , decoration: decoration?? TextDecoration.none );
//     // return GoogleFonts.aBeeZee(color:  color ,fontWeight:  fontWeight,height: height, fontSize:  size_H(fontSize) , decoration: decoration?? TextDecoration.none );
//   //
// }
//
// // double size_H(var hight){
// //   if(hight.runtimeType.toString() == "Int"){
// //     hight = hight.toDouble();
// //   }
// //   return  SizeConfig.heightMultiplier! * (hight / 7.81 ) ;
// // }
//
// String capitalize(name) {
//   return "${name[0].toUpperCase()}${name.substring(1)}";
// }
// ///
// // double size_W(var width){
// //   if(width.runtimeType.toString() == "Int"){
// //     width = width.toDouble();
// //   }
// //   return  SizeConfig.widthMultiplier! * (width / 3.92 ) ;}
//
//
// class T9ButtonReverce extends StatefulWidget {
//   var textContent;
//   VoidCallback? onPressed;
//   Color? color;
//   Color? fontCcolor;
//   BorderRadiusGeometry? borderRadius;
//   FontWeight? fontWeight ;
//   T9ButtonReverce({@required this.textContent,this.fontWeight,this.borderRadius ,this.fontCcolor , this.onPressed, this.color});
//
//   @override
//   State<StatefulWidget> createState() {
//     return T9ButtonReverceState();
//   }
// }
//
// class T9ButtonReverceState extends State<T9ButtonReverce> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: widget.color ?? Primary_Color,
//         borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0),
//       ),
//       child: MaterialButton(
//           onPressed: widget.onPressed,
//           textColor:  Colors.white,
//           elevation: 4,
//           // color: Theme_Information.Button_Color,
//           // color: Theme_Information.Primary_Color,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           padding: const EdgeInsets.all(0.0),
//           child: Container(
//             width: 650,
//             // height: size_H(50),
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             ),
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   widget.textContent,
//                   style: ourTextStyle(fontWeight: widget.fontWeight ?? FontWeight.bold , color: widget.fontCcolor ??Colors.white,),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
//
//
