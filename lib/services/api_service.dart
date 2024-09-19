import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:xetzgpt/constants/api_consts.dart';
import 'package:xetzgpt/models/chat_model.dart';

class ApiService {
  //our app uses text complete api of gemini-1.5-flash model
  static Future<ChatModel?> textCompleteRequest(
    List<ChatModel> previousMessages,
  ) async {
    final url = Uri.parse('$baseUrl$myApiKey');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "contents": previousMessages.map((message) => message.toJson()).toList()
    });

    try {
      log(body.toString());
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        ChatModel respondedChat = ChatModel.fromJson(jsonDecode(response.body));
        return respondedChat;
      } else {
        final responseData = jsonDecode(response.body);
        log('Request failed with status: ${response.statusCode} ${responseData['error']['message']}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }
}
