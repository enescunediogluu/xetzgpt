import 'package:flutter/material.dart';
import 'package:xetzgpt/widgets/drop_down.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: CustomText(
                  label: "Chosen Model: ",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
                SizedBox(width: 10),
                Flexible(
                  flex: 2,
                  child: ModalsDropDownWidget(),
                )
              ],
            ),
          );
        });
  }
}
