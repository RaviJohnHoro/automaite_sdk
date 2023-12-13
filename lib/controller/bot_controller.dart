import 'dart:async';
import 'dart:developer';
import 'package:automaite_android_sdk/model/bot_model.dart';
import 'package:automaite_android_sdk/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BotController {
  Future<BotModel?> getBot({
    String botId = BOTID,
  }) async {
    try {
      final apiUrl = "https://ulai.in/backend/bot/$botId";
      final response = await http.get(Uri.parse(apiUrl));
      log("bot response: ${response.body}");
      if (response.statusCode == 200) {
        return BotModel.fromJson(jsonDecode(response.body));
      } else {
        log("status code:: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("catch block: get bot");
      log(e.toString());
      return null;
    }
  }
}
