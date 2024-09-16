import 'package:flutter/material.dart';
import 'package:xetzgpt/services/assets_manager.dart';
import 'package:xetzgpt/services/color_palette.dart';
import 'package:xetzgpt/widgets/custom_text.dart';

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
              : GptMessage(message: message, chatIndex: chatIndex),
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
            color: ColorPalette.icedBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width *
                0.75, // Set the maximum width for the container
          ),
          child: CustomText(
            label: message,
            color: ColorPalette.primaryColor,
          ),
        ),
      ],
    );
  }
}

class GptMessage extends StatelessWidget {
  final String message;
  final int chatIndex;
  const GptMessage({
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
          chatIndex == 0 ? AssetsManager.userLogo : AssetsManager.gptLogo,
          height: 30,
          width: 30,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: CustomText(label: message),
        ),
      ],
    );
  }
}
