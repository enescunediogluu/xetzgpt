import 'package:flutter/material.dart';
import 'package:xetzgpt/models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatMessages = [];

  List<ChatModel> get getChatMessages => chatMessages;

  void addMessage(ChatModel message) {
    chatMessages.add(message);
    notifyListeners();
  }

  void clearMessages() {
    chatMessages.clear();
    notifyListeners();
  }
}
