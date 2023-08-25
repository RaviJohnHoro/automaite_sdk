import 'package:flutter/services.dart';

const MethodChannel _methodChannel = MethodChannel("data_channel");

class DataChannel {
  static Future<void> receiveData(Function(String?) onDataReceived) async {
    _methodChannel.setMethodCallHandler(
      (call) async {
        if (call.method == "sendData") {
          final String data = call.arguments["data"];
          onDataReceived(data);
        }
      },
    );
  }
}
