import 'package:flutter/material.dart';
import 'package:xetzgpt/constants/constants.dart';

class ModalsDropDownWidget extends StatefulWidget {
  const ModalsDropDownWidget({super.key});

  @override
  State<ModalsDropDownWidget> createState() => _ModalsDropDownWidgetState();
}

class _ModalsDropDownWidgetState extends State<ModalsDropDownWidget> {
  String currentModel = "model_1";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: getModelsItems,
        value: currentModel,
        onChanged: ((value) {
          setState(() {
            currentModel = value.toString();
          });
        }));
  }
}
