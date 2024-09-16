import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String label;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  const CustomText({
    super.key,
    required this.label,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 18,
    this.color = Colors.white,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(label,
        softWrap: true,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          overflow: TextOverflow.visible,
        ));
  }
}
