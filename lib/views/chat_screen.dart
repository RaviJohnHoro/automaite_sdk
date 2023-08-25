import 'dart:developer';
import 'dart:io';

import 'package:automaite_android_sdk/model/message.dart';
import 'package:automaite_android_sdk/service/data_channel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? data;

  @override
  void initState() {
    super.initState();
    DataChannel.receiveData(
      (data) {
        if (data != null) {
          log("received data is: $data");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Received data from android: $data",
              ),
            ),
          );
        }
      },
    );
  }

  final List<Message> _messages = [
    const Message(isSender: false, text: "Hello"),
    const Message(isSender: true, text: "Hi"),
    const Message(isSender: false, text: "How are you?"),
  ];

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: text, isSender: true));
      });
    }
  }

  void _handleImageSelected(String imageUrl) {
    setState(() {
      _messages.add(
        Message(
          imageUrl: imageUrl,
          isSender: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Screen')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
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
                    child: Image.file(
                      File(
                        imageUrl!,
                      ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _handleImageSelected,
          ),
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
