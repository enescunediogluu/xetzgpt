import 'package:flutter/material.dart';
import 'package:xetzgpt/services/assets_manager.dart';
import 'package:xetzgpt/services/color_palette.dart';
import 'package:xetzgpt/widgets/custom_text_widget.dart';

class ChatWidget extends StatelessWidget {
  final String message;
  final int chatIndex;
  const ChatWidget({
    super.key,
    required this.message,
    required this.chatIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          child: chatIndex == 0
              ? UserMessage(chatIndex: chatIndex, message: message)
              : GeminiMessage(message: message, chatIndex: chatIndex),
        ),
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  const UserMessage({
    super.key,
    required this.chatIndex,
    required this.message,
  });

  final int chatIndex;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.repeated,
              colors: [
                ColorPalette.icedBlue,
                ColorPalette.geminiPurple,
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width *
                0.75, // Set the maximum width for the container
          ),
          child: CustomTextWidget(
            selectable: true,
            label: message,
            color: ColorPalette.primaryColor,
          ),
        ),
      ],
    );
  }
}

class GeminiMessage extends StatelessWidget {
  final String message;
  final int chatIndex;
  const GeminiMessage({
    super.key,
    required this.message,
    required this.chatIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AssetsManager.geminiIcon,
          height: 30,
          width: 30,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: CustomTextWidget(
            label: message,
            selectable: true,
          ),
        ),
      ],
    );
  }
}
