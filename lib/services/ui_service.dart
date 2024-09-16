import 'package:flutter/material.dart';
import '../widgets/custom_text.dart';

class UiService {
  static Future<void> showBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return const Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              children: [
                CustomText(label: "Chosen Model: "),
              ],
            ),
          );
        });
  }
}
