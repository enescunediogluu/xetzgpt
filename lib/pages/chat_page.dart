// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:xetzgpt/constants/constants.dart';
import 'package:xetzgpt/services/api_service.dart';
import 'package:xetzgpt/services/color_palette.dart';
import 'package:xetzgpt/services/ui_service.dart';
import 'package:xetzgpt/widgets/chat_widget.dart';
import 'package:xetzgpt/widgets/custom_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isTyping = true;
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              return UiService.showBottomSheet(context);
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
        title: const CustomText(
          label: "XetzGPT",
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    message: chatMessages[index]["msg"].toString(),
                    chatIndex:
                        int.parse(chatMessages[index]["chatIndex"].toString()),
                  );
                },
              ),
            ),
            if (_isTyping) ...{
              SpinKitThreeBounce(
                color: ColorPalette.icedBlue,
                size: 30.0,
              ),
            },
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: ColorPalette.darkGrey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (value) {
                          //todo: send message
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            hintText: "Ask something...",
                            hintStyle: TextStyle(
                              color: ColorPalette.lightGrey,
                            )),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await ApiService.getModels();
                        } catch (error) {
                          log("error : $error");
                        }
                      },
                      icon: const Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
