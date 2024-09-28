
import 'package:flutter/material.dart';
import 'package:forgeapp/commenwidget/textInput.dart';
import 'package:forgeapp/configuration/theme.dart';

Color primaryColor  = Theme_Information.Primary_Color ;

Widget text(String text,
    { var fontSize = textSizeMedium,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.25,
      var textAllCaps = false,
      var isLongText = false}) {
  return Text(textAllCaps ? text.toUpperCase() : text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      style: TextStyle( fontSize: fontSize, height: 1.5, letterSpacing: latterSpacing));

}