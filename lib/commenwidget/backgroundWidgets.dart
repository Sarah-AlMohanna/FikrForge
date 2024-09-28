

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configuration/images.dart';

Widget authScreen({required Widget child ,required context}){
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      color: Colors.transparent,
      image: DecorationImage(
        image: AssetImage(ImagePath.backgroundAuthScreenNew),
        fit: BoxFit.cover,
      ),
    ),
    child: child,
  );
}

Widget homeScreen1({required Widget child ,required context}){
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      color: Colors.transparent,
      image: DecorationImage(
        image: AssetImage(ImagePath.backGroundPage1),
        // Replace with your image path
        fit: BoxFit
            .cover, // You can use other BoxFit values like BoxFit.fill or BoxFit.scaleDown
      ),
    ),
    child: child,
  );
}

Widget homeScreen2({required Widget child ,required context}){
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      color: Colors.transparent,
      image: DecorationImage(
        image: AssetImage(ImagePath.backGroundPage2),
        // Replace with your image path
        fit: BoxFit
            .cover, // You can use other BoxFit values like BoxFit.fill or BoxFit.scaleDown
      ),
    ),
    child: child,
  );
}
Widget homeScreen3({required Widget child ,required context}){
  return Container(
    height: MediaQuery.of(context).size.height,

    decoration: BoxDecoration(
      color: Colors.transparent,
      image: DecorationImage(
        image: AssetImage(ImagePath.backGroundPage3),
        // Replace with your image path
        fit: BoxFit
            .cover, // You can use other BoxFit values like BoxFit.fill or BoxFit.scaleDown
      ),
    ),
    child: child,
  );
}

Widget homeScreen4({required Widget child ,required context}){
  return Container(
    height: MediaQuery.of(context).size.height,

    decoration: BoxDecoration(

      color: Colors.transparent,
      image: DecorationImage(
        image: AssetImage(ImagePath.backGroundPage4),
        // Replace with your image path
        fit: BoxFit
            .cover, // You can use other BoxFit values like BoxFit.fill or BoxFit.scaleDown
      ),
    ),
    child: child,
  );
}



Widget homeScreen({required Widget child ,required context}){
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      color: Colors.transparent,
      image: DecorationImage(
        image: AssetImage(ImagePath.backgroundHomeScreen),
        // Replace with your image path
        fit: BoxFit
            .cover, // You can use other BoxFit values like BoxFit.fill or BoxFit.scaleDown
      ),
    ),
    child: child,
  );
}