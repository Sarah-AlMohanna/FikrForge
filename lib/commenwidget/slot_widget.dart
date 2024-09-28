// import 'package:flutter/material.dart';
// import 'package:forgeapp/commenwidget/string_extensions.dart';
// import 'package:forgeapp/configuration/theme.dart';
//
// class SlotWidget extends StatelessWidget {
//   final bool isAvailable;
//   final bool isSelected;
//   final String value;
//   final Color activeColor;
//   final Color inActiveColor;
//   final Function() onTap;
//
//   SlotWidget({
//     required this.isAvailable,
//     required this.isSelected,
//     required this.value,
//     this.activeColor = Colors.green,
//     this.inActiveColor = Colors.green,
//     required this.onTap,
//   });
//
//   Color _getBackgroundColor(BuildContext context) {
//     if (isAvailable && isSelected) {
//       return activeColor;
//     } else if (isSelected) {
//       return activeColor;
//     } else {
//       return Theme_Information.Primary_Color;
//     }
//   }
//
//   Color _getTextColor() {
//     if (isAvailable && isSelected) {
//       return Colors.white;
//     } else if (isSelected) {
//       return Colors.white;
//     } else {
//       return Theme_Information.Color_7!;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: MediaQuery.of(context).size.width / 3 - 22,
//         decoration: boxDecorationDefault(
//           boxShadow: defaultBoxShadow(blurRadius: 0, spreadRadius: 0),
//           border: Border.all(color: isAvailable ? activeColor : Colors.transparent),
//           color: _getBackgroundColor(context),
//         ),
//         padding: EdgeInsets.all(12),
//         child: Observer(builder: (context) {
//           return Text(
//             appStore.is24HourFormat ? value.splitBefore(':00') : TimeOfDay(hour: value.split(':').first.toInt(), minute: 00).format(context),
//             style: ourTextStyle(color: _getTextColor()),
//           ).center();
//         }),
//       ),
//     );
//   }
//   /// default box shadow
//   List<BoxShadow> defaultBoxShadow({
//     Color? shadowColor,
//     double blurRadius,
//     double spreadRadius,
//     Offset offset = const Offset(0.0, 0.0),
//   }) {
//     return [
//       BoxShadow(
//         color: shadowColor ?? Colors.orange,
//         blurRadius: blurRadius ,
//         spreadRadius: spreadRadius,
//         offset: offset,
//       )
//     ];
//   }
//   Decoration boxDecorationDefault({
//     BorderRadiusGeometry? borderRadius,
//     Color? color,
//     Gradient? gradient,
//     BoxBorder? border,
//     BoxShape? shape,
//     BlendMode? backgroundBlendMode,
//     List<BoxShadow>? boxShadow,
//     DecorationImage? image,
//   }) {
//     return BoxDecoration(
//       borderRadius: (shape != null && shape == BoxShape.circle)
//           ? null
//           : (borderRadius),
//       boxShadow: boxShadow,
//       color: color ?? Colors.white,
//       gradient: gradient,
//       border: border,
//       shape: shape ?? BoxShape.rectangle,
//       backgroundBlendMode: backgroundBlendMode,
//       image: image,
//     );
//   }
//
// }
