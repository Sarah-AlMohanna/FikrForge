import 'package:flutter/material.dart';
import 'package:forgeapp/configuration/theme.dart';

class TextFieldWidgetPhone extends StatelessWidget {
  const TextFieldWidgetPhone({
    Key? key,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.iconData,
    this.labelText,
    this.obscureText,
    this.suffixIcon,
    this.isFirst,
    this.phoneWidget,
    this.isLast,
    this.style,
    this.textAlign,
    this.controller,
  }) : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final IconData? iconData;
  final bool? obscureText;
  final bool? isFirst;
  final bool? isLast;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Widget? phoneWidget;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        // padding: EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
        // margin: EdgeInsets.only(left: 20, right: 20, top: topMargin, bottom: bottomMargin),
        // padding: EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
        margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
        decoration: BoxDecoration(
            // color: Theme_Information.Color_7!.withOpacity(0.1) ,
            color: Theme_Information.Color_1,
            borderRadius: buildBorderRadius,
            // boxShadow: [
            //   BoxShadow(color: Theme_Information.Second_Color.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
            // ],
        ///
            // border: Border.all(color: Theme_Information.Primary_Color.withOpacity(0.5), width: 1)
        ),

            // border: Border.all(color: Theme_Information.Second_Color.withOpacity(0.05) , width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   labelText ?? "",
            //   style: ourTextStyle(
            //     color: Theme_Information.Primary_Color,
            //     fontSize: 12.0,
            //     fontWeight: FontWeight.w400,
            //   ),
            //   textAlign: textAlign ?? TextAlign.start,
            // ),
            ///
            // TextFormField(
            //   keyboardType: keyboardType ?? TextInputType.text,
            //   onSaved: onSaved,
            //   validator: validator,
            //   initialValue: initialValue ?? '',
            //   style: style ?? OurTextStyle().title14(
            //     color: Theme_Information.Second_Color,
            //     fontSize: 13.0,
            //     fontWeight: FontWeight.w600,
            //   ),
            //   obscureText: obscureText ?? false,
            //   textAlign: textAlign ?? TextAlign.start,
            //   decoration: getInputDecoration(
            //     hintText: hintText ?? '',
            //     iconData: iconData,
            //     suffixIcon: suffixIcon,
            //   ),
            // ),
            Row(
              children: [
                phoneWidget!,
                Expanded(
                  child: TextFormField(
                    keyboardType: keyboardType ?? TextInputType.text,
                    onSaved: onSaved,
                    validator: validator,
                    controller: controller,
                    // initialValue: initialValue ?? '',
                    style: style ?? ourTextStyle(
                      color: Theme_Information.Primary_Color,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                    obscureText: obscureText ?? false,
                    textAlign: textAlign ?? TextAlign.start,
                    decoration: getInputDecoration(
                      hintText: hintText ?? '',
                      // iconData: iconData,
                      // suffixIcon: suffixIcon,
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst == true) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast== true ) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && isFirst== false  && isLast != null && isLast == false) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst== true )) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast== true)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
  static InputDecoration getInputDecoration({String hintText = '', IconData? iconData, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: ourTextStyle(
        color: Theme_Information.Second_Color,
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
      ),
      prefixIcon: iconData != null ? Container(
          margin: EdgeInsets.only(right: 14),
          child: Icon(iconData, color: Theme_Information.Second_Color))
      // .marginOnly(right: 14)
          : SizedBox(),
      prefixIconConstraints: iconData != null ? BoxConstraints.expand(width: 38, height: 38) : BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      // contentPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
    );
  }
}