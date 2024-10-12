import 'package:flutter/material.dart';
import 'package:forgeapp/configuration/theme.dart';

Widget T9EditTextStyle(
    var hintText, TextEditingController textEditingController, {bool isEnable = true, IconData? iconData
      , int? maxLines ,TextInputType textInputType = TextInputType.text}) {
  return Padding(
    padding:  EdgeInsets.only(right: size_W(20), left: size_W(20)),
    child: Container(
      // decoration: boxDecoration(radius: 40, showShadow: true, bgColor: t9_white),
      child: TextFormField(
        enabled: isEnable,
        // style: TextStyle(fontSize: textSizeMedium, ),
        style: ourTextStyle(fontSize: 15, ),
        controller: textEditingController,
        maxLines: maxLines,

        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        /*
        decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Write your Problem here',
                        labelStyle: ourTextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          // textAlign: TextAlign.center,
                        ),
                      ),
         */
        decoration: InputDecoration(
          fillColor:    Theme_Information.Color_9,
          border: OutlineInputBorder(),
          prefixIcon: iconData != null ? Icon(iconData) : null,
          labelStyle: ourTextStyle(),
          labelText: hintText,
          // labelStyle: TextStyle(
          //   color: Colors.grey,
          //   fontSize: 14.0,
          //   // textAlign: TextAlign.center,
          // ),
          // contentPadding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
          // hintText: hintText,
          filled: true,
          // fillColor: Theme_Information.Icon_Back_Color,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(color: t9_white, width: 0.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(color: t9_white, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(color: t9_white, width: 0.0),
          ),
        ),
      ),
    ),
  );
}


Widget T9EditTextStyleWithoutPadding(
    var hintText, TextEditingController textEditingController, {IconData? iconData ,TextInputType textInputType = TextInputType.text}) {
  return Container(
    // decoration: boxDecoration(radius: 40, showShadow: true, bgColor: t9_white),
    child: TextFormField(

      // style: TextStyle(fontSize: textSizeMedium, ),
      style: ourTextStyle(fontSize: 15, ),
      controller: textEditingController,
      keyboardType: textInputType,
      textInputAction: TextInputAction.next,
      /*
      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Write your Problem here',
                      labelStyle: ourTextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        // textAlign: TextAlign.center,
                      ),
                    ),
       */
      decoration: InputDecoration(
        fillColor: Theme_Information.Color_1,
        border: OutlineInputBorder(),
        prefixIcon: iconData != null ? Icon(iconData) : null,
        labelStyle: ourTextStyle(),
        labelText: hintText,
        // labelStyle: TextStyle(
        //   color: Colors.grey,
        //   fontSize: 14.0,
        //   // textAlign: TextAlign.center,
        // ),
        // contentPadding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
        // hintText: hintText,
        filled: true,
        // fillColor: Theme_Information.Icon_Back_Color,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  const BorderSide(color: t9_white, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  const BorderSide(color: t9_white, width: 0.0),
        ),
      ),
    ),
  );
}




Widget T9EditTextStylePassword(
    var hintText, TextEditingController textEditingController, {IconData iconData = Icons.password_rounded ,  TextInputType textInputType = TextInputType.text,
      isHidden = false , Function()? function }) {
  return Padding(
    padding:  EdgeInsets.only(right: size_W(20), left: size_W(20)),
    child: Container(
      // color: Theme_Information.Color_1,
      // decoration: boxDecoration(radius: 40, showShadow: true, bgColor: t9_white),
      child: TextFormField(
        style: ourTextStyle(fontSize: 15, ),
        obscureText: isHidden,
        controller: textEditingController,
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Theme_Information.Color_9,
          // prefixIcon: Icon(iconData),
          suffixIcon: isHidden != null ?
          InkWell(
              onTap: function,
              child: isHidden ? Icon(Icons.remove_red_eye_outlined ,  color: Theme_Information.Primary_Color) : Icon(Icons.remove_red_eye , color: Theme_Information.Primary_Color,)) : null,
          contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
          labelText: hintText,
          filled: true,
          labelStyle: ourTextStyle(),
          // fillColor: Theme_Information.Icon_Back_Color,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(color: t9_white, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  const BorderSide(color: t9_white, width: 0.0),
          ),
        ),
      ),
    ),
  );
}


const t9_white = Color(0xFFffffff);
const textSizeMedium = 16.0;
const t9_ShadowColor = Color(0X95E9EBF0);

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color bgColor = t9_white, var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow ? [BoxShadow(color: t9_ShadowColor, blurRadius: 10, spreadRadius: 2)] : [BoxShadow(color: Colors.transparent)],
  border: Border.all(color: color),
  borderRadius: BorderRadius.all(Radius.circular(radius)));
}

