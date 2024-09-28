import 'package:flutter/material.dart';
import 'package:forgeapp/configuration/theme.dart';

import '../configuration/images.dart';

PreferredSize myAppBarBadr({required String title, List<Widget>? actions}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(100.0),
    child: CustomAppBarBadr(title: title, actions: actions),
  );
}

class CustomAppBarBadr extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;

  const CustomAppBarBadr({Key? key, this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      child: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
            // colors: [Theme_Information.Primary_Color, Theme_Information.Primary_Color],
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
          // ),
        ),
        child: Padding(
          padding:  EdgeInsets.only(top: size_H(30), left: 20, right: 20 , bottom: 20),
          child:
          AppBar(
            title: Text(title!,
                style: TextStyle(
                  color: Theme_Information.Color_1,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                )),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Theme_Information.Color_1 //change your color here
            ),
            elevation: 0,
            actions: actions,
          ),
        ),
      ),
    );
  }
}