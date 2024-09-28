import 'package:forgeapp/configuration/theme.dart';
import 'package:flutter/material.dart';

class CircularProfilePhoto extends StatelessWidget {
  final String imageUrl;
  final Color borderColor;
  final double borderWidth;

  CircularProfilePhoto({
    required this.imageUrl,
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size_H(40),
      height: size_H(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


