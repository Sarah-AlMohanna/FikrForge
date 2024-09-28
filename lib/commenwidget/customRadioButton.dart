import 'package:flutter/material.dart';
import 'package:forgeapp/configuration/theme.dart';

class CustomRadioButton extends StatefulWidget {
  final String text;
  final int value;
  final int groupValue;
  final TextStyle? styleText;
  final Function(int?)? onChanged;

  CustomRadioButton({
    required this.text,
    required this.value,
    required this.styleText,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Radio(
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: widget.onChanged,
            activeColor: Colors.white,
            focusColor: Colors.white,
            hoverColor: Colors.white,
          ),
          Text(widget.text, style: widget.styleText,),
        ],
      ),
    );
  }
}