import 'package:flutter/material.dart';
import 'package:forgeapp/commenwidget/textInput.dart';

import '../configuration/theme.dart';

class T9Button extends StatefulWidget {
  var textContent;
  VoidCallback? onPressed;

  T9Button({@required this.textContent, this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return T9ButtonState();
  }
}

class T9ButtonState extends State<T9Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Theme_Information.Second_Color.withOpacity(0.7), width: 2),

        // gradient: LinearGradient(
        //   colors: [Theme_Information.Primary_Color, Theme_Information.Second_Color],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        color: Theme_Information.Primary_Color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
          onPressed: widget.onPressed,
          textColor: t9_white,
          elevation: 4,
          // color: Theme_Information.Button_Color,
          // color: Theme_Information.Primary_Color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: 650,
            // height: size_H(50),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.textContent,
                  style: ourTextStyle(fontWeight: FontWeight.bold , color: Theme_Information.Color_1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
    );
  }
}


class T9ButtonReverce extends StatefulWidget {
  var textContent;
  Color? color;
  VoidCallback? onPressed;

  T9ButtonReverce({@required this.textContent, this.onPressed, this.color});

  @override
  State<StatefulWidget> createState() {
    return T9ButtonReverceState();
  }
}

class T9ButtonReverceState extends State<T9ButtonReverce> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Theme_Information.Second_Color.withOpacity(0.7), width: 2),

        // gradient: LinearGradient(
        //   colors: [Theme_Information.Primary_Color, Theme_Information.Second_Color],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        color: widget.color ?? Theme_Information.Primary_Color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
          onPressed: widget.onPressed,
          textColor: t9_white,
          elevation: 4,
          // color: Theme_Information.Button_Color,
          // color: Theme_Information.Primary_Color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: 650,
            // height: size_H(50),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.textContent,
                  style: ourTextStyle(fontWeight: FontWeight.bold , color: Theme_Information.Color_1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
    );
  }
}



class T9ButtonRounded extends StatefulWidget {
  var textContent;
  VoidCallback? onPressed;

  T9ButtonRounded({@required this.textContent, this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return T9ButtonRoundedState();
  }
}

class T9ButtonRoundedState extends State<T9ButtonRounded> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme_Information.Second_Color,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: MaterialButton(
          onPressed: widget.onPressed,
          textColor: t9_white,
          elevation: 4,
          // color: Theme_Information.Button_Color,
          // color: Theme_Information.Primary_Color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: 650,
            // height: size_H(50),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.textContent,
                  style: ourTextStyle(fontWeight: FontWeight.bold , color: Theme_Information.Color_1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
    );
  }
}



class T9ButtonCancel extends StatefulWidget {
  var textContent;
  VoidCallback? onPressed;

  T9ButtonCancel({@required this.textContent, this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return T9ButtonCancelState();
  }
}

class T9ButtonCancelState extends State<T9ButtonCancel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Theme_Information.Button_Color2.withOpacity(0.7), width: 2)
      ),
      child: MaterialButton(
          onPressed: widget.onPressed,
          textColor: t9_white,
          elevation: 4,
          // color: Theme_Information.Button_Color,
          // color: Theme_Information.Primary_Color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: 650,
            // height: size_H(50),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.textContent,
                  style: ourTextStyle(fontWeight: FontWeight.bold , color: Theme_Information.Color_1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
    );
  }
}

