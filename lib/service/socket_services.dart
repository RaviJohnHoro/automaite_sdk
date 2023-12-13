import 'dart:convert';
import 'dart:developer';
import 'package:automaite_android_sdk/model/bot_response_model.dart';
import 'package:automaite_android_sdk/model/chat_model.dart';
import 'package:automaite_android_sdk/model/room_exists_model.dart';
import 'package:automaite_android_sdk/model/session_model.dart';
import 'package:automaite_android_sdk/model/user_data_model.dart';
import 'package:automaite_android_sdk/provider/chat_provider.dart';
import 'package:automaite_android_sdk/utils/constant.dart';
import 'package:automaite_android_sdk/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:uuid/uuid.dart';

io.Socket initialiseSocket({
  required io.Socket? socket,
  required String organisationId,
  required Function(String) setRoomId,
  required BuildContext context,
}) {
  const baseUrl = 'https://www.ulai.in';

  socket = io.io(baseUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
    'path': '/agent-live-chat-socket/',
  });

  socket.connect();

  socket.on("connect", (data) {
    log("here");
    createOrConnectRoom(
      socket: socket!,
      organisationId: organisationId,
      setRoomId: setRoomId,
    );
  });
  socket.on("room-id", (data) {
    log("room_id: $data");
  });

  socket.on("room-update", (data) {
    log("room_update: $data");
  });

  socket.on("conn-prepare", (data) {
    log("conn_prepare: $data");
  });
  socket.on("conn-signal", (data) {
    log("conn_signal: $data");
  });

  socket.on("conn-init", (data) {
    log("conn_init: $data");
  });

  socket.on("user-disconnected", (data) {
    log("user_disconnected: $data");
  });

  socket.on(
    "message-recieved",
    (data) {
      log("message-received: $data");
      BotResponseModel model = BotResponseModel.fromJson(jsonDecode(data));
      Provider.of<ChatProvider>(context, listen: false).getMessageList(model);
    },
  );
  socket.on("disconnect", (data) {
    log("disconnect: $data");
  });
  return socket;
}

Future<String> getSessionId(String parameter) async {
  var prefs = await SharedPreferences.getInstance();

  // Check if a session exists for the parameter
  log("Paramete: $parameter");
  var sessions = prefs.getString(SESSIONS) ?? "";
  log("getSessionIdSessions $sessions");
  if (sessions.isNotEmpty) {
    SessionModel existingSession = SessionModel.fromJson(jsonDecode(sessions));

    if (getMillisecondsSinceEpoch() - int.parse(existingSession.lastUsed!) <=
        30 * 60 * 1000) {
      // If session exists and is valid

      existingSession = existingSession.copyWith(
        lastUsed: getMillisecondsSinceEpoch().toString(),
      );
      //   console.log(
      //     "ExistingSession",
      //     Object.keys(sessions[0]).find((key) => {
      //       //sessions[key] === existingSession;
      //       console.log("sessions[key]:", key);
      //     })
      //   );
      return existingSession.sessionId!;
    } else {
      return "";
    }
  } else {
    // Create a new session linked to the parameter
    final sessionId = const Uuid().v4();
    log("generatedsessionID $sessionId");

    var localSession = SessionModel.fromJson({
      "sessionId": sessionId,
      "parameter": parameter,
      "lastUsed": getMillisecondsSinceEpoch()
    });

    prefs.setString(SESSIONS, jsonEncode(localSession.toJson()));

    return sessionId;
  }
}

Future<RoomExistsModel> getRoomExists(String roomId) async {
  const url = "https://ulai.in/agent-live-chat";
  final response = await http.get(Uri.parse("$url/api/room-exists/$roomId"));
  return RoomExistsModel.fromJson(
    jsonDecode(
      response.body,
    ),
  );
}

Future<void> createOrConnectRoom({
  required io.Socket socket,
  required String organisationId,
  required Function(String) setRoomId,
}) async {
  var prefs = await SharedPreferences.getInstance();
  var sessionUuid = prefs.getString(SESSIONUUID);
  var roomId = await getSessionId(sessionUuid ?? "");

  final data = UserDataModel.fromJson({
    "identity": "USER",
    "defaultConnection": socket.id,
    "roomId": roomId,
    "organization_id": organisationId,
  });

  if (organisationId.isEmpty) {
    log("no organisation id");
    return;
  } else {
    if (roomId.isEmpty) {
      log("empty room");
      var roomId = const Uuid().v4();
      prefs.setString(CONNECTIONID, roomId);
      setRoomId(roomId);
      log(data.toString());
      socket.emit("create-new-room", data);
      socket.emit("join-room", data);
    } else {
      log("room present");
      final resp = await getRoomExists(roomId);
      if (!resp.roomExists) {
        socket.emit("create-new-room", data);
      }
      setRoomId(roomId);
      socket.emit("join-room", data);
      return;
    }
  }
}

Future<void> joinSession(
  String roomId,
  io.Socket socket,
) async {
  var data = {
    "identity": "AGENT",
    "roomId": roomId,
  };
  socket.emit("join-room", data);
}

Future<void> sendDataToConnectedUser(
  var data,
  io.Socket socket,
) async {
  socket.emit("mssg-sent", data);
}
