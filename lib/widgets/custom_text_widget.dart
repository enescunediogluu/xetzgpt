import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CustomTextWidget extends StatelessWidget {
  final String label;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final bool selectable;
  final WrapAlignment wrapAlignment;
  const CustomTextWidget({
    super.key,
    required this.label,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 18,
    this.color = Colors.white,
    this.textAlign = TextAlign.left,
    this.selectable = false,
    this.wrapAlignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: label,
      selectable: selectable,
      styleSheet: MarkdownStyleSheet(
        textAlign: wrapAlignment,
        p: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
