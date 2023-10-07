import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:automaite_android_sdk/controller/chat_controller.dart';
import 'package:automaite_android_sdk/model/chat_model.dart';
import 'package:automaite_android_sdk/model/message.dart';
import 'package:automaite_android_sdk/model/message_model.dart';
import 'package:automaite_android_sdk/service/data_channel.dart';
import 'package:automaite_android_sdk/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? data;

  final ChatController controller = ChatController();
  late SharedPreferences prefs;

  initialise() async {
    prefs = await SharedPreferences.getInstance();
    String storedMessage = prefs.getString(MESSAGES) ?? "";
    if (storedMessage.isNotEmpty) {
      log("stored message : $storedMessage");
      storedMessage.split(SEPARATOR).forEach((e) {
        log("eeeee : $e");
        _messages.insert(
          0,
          Message.fromJson(jsonDecode(e)),
        );
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialise();
    // DataChannel.receiveData(
    //   (data) {
    //     if (data != null) {
    //       log("received data is: $data");
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text(
    //             "Received data: $data",
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  final List<Message> _messages = [];

  List<Message> getMessageList(ChatModel chatModel) {
    var data = chatModel.data!;
    var messages = <Message>[];
    if (data.productList != null && data.productList!.isNotEmpty) {
      for (var e in data.productList!) {
        messages.add(Message(imageUrl: e.imageUrl));
      }
      return messages;
    } else {
      return [Message(text: data.message)];
    }
  }

  saveMessage() {
    List<String> stringMessages = [];
    for (var e in _messages) {
      log("message: ${e.toJson()}}");
      stringMessages.insert(0, jsonEncode(e.toJson()));
    }

    prefs.setString(MESSAGES, stringMessages.join(SEPARATOR));
  }

  void _handleSubmitted(String text) async {
    FocusScope.of(context).unfocus();
    if (text.isNotEmpty) {
      var message = Message(text: text, isSender: true);
      setState(() {
        _messages.insert(0, message);
      });
      saveMessage();

      await controller.getChatResponse(message: text).then(
        (value) {
          if (value == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error fetching response'),
              ),
            );
          } else {
            var chatMessages = getMessageList(value);
            setState(() {
              _messages.insertAll(0, chatMessages);
            });
            saveMessage();
          }
        },
      );
    }
  }

  void _handleImageSelected(String imageUrl) {
    // setState(() {
    //   _messages.insert(
    //     0,
    //     Message(
    //       imageUrl: imageUrl,
    //       isSender: true,
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Screen')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                return ChatMessage(
                  isSender: message.isSender,
                  text: message.text,
                  imageUrl: message.imageUrl,
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          ChatInputBar(
            onSubmitted: _handleSubmitted,
            onImageSelected: _handleImageSelected,
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String? text;
  final String? imageUrl;
  final bool isSender;

  const ChatMessage({
    this.text,
    this.imageUrl,
    required this.isSender,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isSender ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: imageUrl == null
                ? Text(text ?? "")
                : SizedBox(
                    height: 200,
                    width: 100,
                    child: Image.network(
                      imageUrl!,
                    ),
                  ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            isSender ? 'You' : 'Bot',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatInputBar extends StatefulWidget {
  final Function(String) onSubmitted;
  final Function(String) onImageSelected;

  const ChatInputBar({
    required this.onSubmitted,
    required this.onImageSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    widget.onSubmitted(text);
  }

  void _handleImageSelected() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      widget.onImageSelected(pickedImage.path);
    }

    // try {
    //   pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //   if (pickedImage != null) {
    //     widget.onImageSelected(pickedImage.path);
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         e.toString(),
    //       ),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.image),
          //   onPressed: _handleImageSelected,
          // ),
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}
