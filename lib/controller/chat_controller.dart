import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:automaite_android_sdk/model/chat_model.dart';
import 'package:automaite_android_sdk/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatController {
  Future<ChatModel?> getChatResponse({
    bool hasMedia = false,
    List<String> imageUrls = const [],
    String message = '',
  }) async {
    try {
      const apiUrl = '$BASEURL/backend/bot/chat';

      late http.Response response;
      var headers = {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1MjE0NjJkMjViZTRmMWIwOTc3OGIxMyIsImlhdCI6MTY5NjY4MzEzM30.tqs_6EjrmvuPtexx3Mukxga--bo2DEeVNqnEp3XIVCw",
      };

      if (hasMedia) {
        final request = await http.MultipartRequest('POST', Uri.parse(apiUrl));

        for (var image in imageUrls) {
          final multipartFile = await http.MultipartFile.fromPath(
            'images', // Field name for the image data in the form
            image,
          );
          request.files.add(multipartFile);
        }

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        var body = {
          // "hasMedia": hasMedia,
          // "imageUrl": imageUrls,
          "sessionId": "917739772728@c.us",
          "message": message,
          "phoneNumber": "917739772728"
        };
        response = await http.post(
          Uri.parse(apiUrl),
          headers: headers,
          body: jsonEncode(
            body,
          ),
        );
      }

      log("response is: ${response.body}");

      if (response.statusCode == 200) {
        var model = ChatModel.fromJson(
          jsonDecode(
            response.body,
          ),
        );
        return model;
      } else {
        return null;
      }
    } catch (e) {
      log("catch block: getChatResponse");
      log(e.toString());
      return null;
    }
  }
}
