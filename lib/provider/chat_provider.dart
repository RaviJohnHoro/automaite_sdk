import 'dart:convert';
import 'dart:developer';
import 'package:automaite_android_sdk/controller/bot_controller.dart';
import 'package:automaite_android_sdk/model/bot_model.dart';
import 'package:automaite_android_sdk/model/bot_response_model.dart';
import 'package:automaite_android_sdk/model/message.dart';
import 'package:automaite_android_sdk/service/socket_services.dart';
import 'package:automaite_android_sdk/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatProvider extends ChangeNotifier {
  bool isConnected = false;
  List<Message> messages = [];
  BotModel? botModel;
  String roomId = "";
  bool showTyping = false;
  String sessionId = "";
  late SharedPreferences prefs;
  io.Socket? socket;

  // saveMessage() {
  //   List<String> stringMessages = [];
  //   for (var e in messages) {
  //     log("saving message: ${e.toJson()}}");
  //     stringMessages.insert(0, jsonEncode(e.toJson()));
  //   }

  //   prefs.setString(MESSAGES, stringMessages.join(SEPARATOR));
  // }

  getMessageList(BotResponseModel botResponse) {
    var _messages = <Message>[];
    log("${botResponse.productList != null} ${botResponse.productList?.isNotEmpty}");
    messages.removeWhere((e) => e.showLoader);

    if (botResponse.possibleUserResponses != null &&
        botResponse.possibleUserResponses!.isNotEmpty) {
      _messages.add(
        Message(
          isSender: true,
          possibleUserResponses: botResponse.possibleUserResponses ?? [],
        ),
      );
    }

    if (botResponse.productList != null &&
        botResponse.productList!.isNotEmpty) {
      log("hereeeee");
      for (var e in botResponse.productList!) {
        log("image: ${e.images!.first}");
        _messages.add(
          Message(
            product: e,
          ),
        );
      }
    }
    _messages.add(
      Message(text: botResponse.message),
    );
    //else {
    //   log("here");
    //   _messages = [Message(text: botResponse.message)];
    // }
    messages.insertAll(0, _messages);
    //saveMessage();
    notifyListeners();
  }

  insertMessage(Message message) {
    messages.insert(0, message);
    notifyListeners();
  }

  // insertAllMessages(List<Message> messages) {}

  getBotDetails(
    String botId,
    BuildContext context,
  ) async {
    var botController = BotController();
    await botController.getBot().then(
      (value) async {
        botModel = value;
        notifyListeners();
        if (value != null) {
          socket = initialiseSocket(
            context: context,
            socket: socket,
            organisationId: botModel!.userId!,
            setRoomId: (value) {
              roomId = value;
            },
          );
          prefs = await SharedPreferences.getInstance();
          String storedMessage = prefs.getString(MESSAGES) ?? "";
          if (storedMessage.isNotEmpty) {
            log("stored message : $storedMessage");
            storedMessage.split(SEPARATOR).forEach((e) {
              log("eeeee : $e");
              messages.insert(
                0,
                Message.fromJson(jsonDecode(e)),
              );
            });
          }
        }
      },
    );
  }
}
