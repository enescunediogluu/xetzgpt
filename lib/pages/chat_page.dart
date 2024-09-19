// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:xetzgpt/models/chat_model.dart';
import 'package:xetzgpt/services/api_service.dart';
import 'package:xetzgpt/services/assets_manager.dart';
import 'package:xetzgpt/services/chat_provider.dart';
import 'package:xetzgpt/services/color_palette.dart';
import 'package:xetzgpt/widgets/chat_widget.dart';
import 'package:xetzgpt/widgets/custom_text_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isTyping = false;
  late TextEditingController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //scrolls to the end of messages list
  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  //sends message to the api
  Future<void> _sendMessage() async {
    ChatProvider provider = Provider.of<ChatProvider>(context, listen: false);
    try {
      if (_controller.text.isNotEmpty) {
        setState(() {
          _isTyping = true;
        });

        provider.addMessage(ChatModel(
          role: 'user',
          text: _controller.text,
        ));

        _controller.text = '';

        ChatModel? response =
            await ApiService.textCompleteRequest(provider.chatMessages);

        if (response != null) {
          provider.addMessage(response);
        }

        setState(() {
          _isTyping = false;
        });
      }
    } catch (error) {
      log("error : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMessagesListEmpty =
        Provider.of<ChatProvider>(context).chatMessages.isEmpty;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Provider.of<ChatProvider>(context, listen: false).clearMessages();
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
        title: const CustomTextWidget(
          label: "XetzGPT",
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            isMessagesListEmpty
                ? _placeHolderWidget()
                : _messageBuilderWidget(),
            if (_isTyping) ...{
              SpinKitThreeBounce(
                color: ColorPalette.icedBlue,
                size: 30.0,
              ),
            },
            const SizedBox(height: 15),
            _textFieldWidget()
          ],
        ),
      ),
    );
  }

  Widget _placeHolderWidget() {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image(
                  image: AssetImage(
                    AssetsManager.geminiIcon,
                  ),
                  height: 50,
                ),
                const SizedBox(height: 15),
                CustomTextWidget(
                  label: "How can i help you?",
                  color: ColorPalette.secondaryColor,
                  fontSize: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _questionCards()
          ],
        ),
      ),
    );
  }

  Widget _messageBuilderWidget() {
    return Flexible(
      child: Consumer<ChatProvider>(
        builder: (BuildContext context, ChatProvider value, Widget? child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToEnd();
          });
          return ListView.builder(
            controller: _scrollController,
            itemCount: value.chatMessages.length,
            itemBuilder: (context, index) {
              return ChatWidget(
                message: value.chatMessages[index].text,
                chatIndex: value.chatMessages[index].role == 'user' ? 0 : 1,
              );
            },
          );
        },
      ),
    );
  }

  Widget _textFieldWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Material(
        borderRadius: BorderRadius.circular(60),
        color: ColorPalette.darkGrey,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _controller,
                  cursorColor: ColorPalette.primaryColor.withOpacity(0.6),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Ask something...",
                      hintStyle: TextStyle(
                        color: ColorPalette.secondaryColor.withOpacity(0.6),
                      )),
                ),
              ),
            ),
            IconButton(
              onPressed: _isTyping ? null : _sendMessage,
              icon: Icon(
                Icons.send,
                color: _isTyping ? ColorPalette.midGrey : ColorPalette.icedBlue,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _questionCards() {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          List<Map<String, dynamic>> defaultQuestions = [
            {
              "question": "What is game theory?",
              "icon": Icons.videogame_asset,
            },
            {
              "question": "Tell me an interesting fact.",
              "icon": Icons.lightbulb,
            },
            {
              "question": "How do you make a cup of coffee?",
              "icon": Icons.local_cafe,
            },
            {
              "question": "What are the latest tech trends?",
              "icon": Icons.trending_up,
            },
          ];

          return GestureDetector(
            onTap: () {
              _controller.text = defaultQuestions[index]["question"];
              _sendMessage();
            },
            child: Container(
              width: 170,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorPalette.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        defaultQuestions[index]["icon"],
                        size: 40,
                        color: ColorPalette.icedBlue,
                      ),
                      const SizedBox(height: 10),
                      CustomTextWidget(
                        wrapAlignment: WrapAlignment.center,
                        label: defaultQuestions[index]["question"],
                        color: ColorPalette.secondaryColor,
                        fontSize: 16,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
