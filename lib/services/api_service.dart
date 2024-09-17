import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:xetzgpt/constants/api_consts.dart';
import 'package:xetzgpt/models/models_model.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    // Fetch models from the server
    try {
      Response response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {"Authorization": "Bearer $MY_API_KEY"},
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List temp = [];

      for (var value in jsonResponse['data']) {
        temp.add(value);
        log("value: ${value['object']}");
      }

      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("error : $error");
      rethrow;
    }
  }
}
