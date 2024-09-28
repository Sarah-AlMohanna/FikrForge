
import 'package:flutter/material.dart';

import '../configuration/theme.dart';

class CustomDatePickerTheme {
  ThemeData datePickerTheme = ThemeData.light().copyWith(
    dialogTheme: const DialogTheme(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)))),
    colorScheme: ColorScheme.light(
      primary: Theme_Information.Primary_Color.withOpacity(0.5), // header background color
      // onPrimary: , // header text color
      onSurface: Theme_Information.Second_Color, // body text color
    ),
  );
}