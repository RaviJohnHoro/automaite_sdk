import 'dart:convert';
import 'dart:developer';

import 'package:automaite_android_sdk/controller/chat_controller.dart';
import 'package:automaite_android_sdk/model/message.dart';
import 'package:automaite_android_sdk/provider/cart_provider.dart';
import 'package:automaite_android_sdk/provider/chat_provider.dart';
import 'package:automaite_android_sdk/service/data_channel.dart';
import 'package:automaite_android_sdk/service/socket_services.dart';
import 'package:automaite_android_sdk/utils/constant.dart';
import 'package:automaite_android_sdk/utils/helper_functions.dart';
import 'package:automaite_android_sdk/views/cart_view.dart';
import 'package:automaite_android_sdk/widgets/chat_input_bar.dart';
import 'package:automaite_android_sdk/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? data;

  //final ChatController controller = ChatController();
  late SharedPreferences prefs;

  String errorString = "";
  //BotModel? bot;
  initialise() async {
    await SharedPreferences.getInstance().then((value) {
      prefs = value;
      Provider.of<ChatProvider>(context, listen: false).getBotDetails(
        BOTID,
        context,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    initialise();
    DataChannel.receiveData(
      (data) {
        if (data != null) {
          log("received data is: $data");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Received data: $data",
              ),
            ),
          );
        }
      },
    );
  }

  void _handleSubmitted(String text) async {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    var bot = chatProvider.botModel!;
    FocusScope.of(context).unfocus();
    if (text.isNotEmpty) {
      var message = Message(text: text, isSender: true);
      chatProvider.insertMessage(message);
      chatProvider.insertMessage(
        const Message(
          isSender: false,
          showLoader: true,
        ),
      );
      chatProvider.messages
          .removeWhere((e) => e.possibleUserResponses.isNotEmpty);
      var sendData = {
        "identity": "USER",
        "message": text,
        "roomId": await getSessionId(prefs.getString(SESSIONUUID) ?? ""),
        "organization_id": bot.userId,
        "type": bot.botType,
        "time": "",
      };

      log("senddata is: $sendData");

      sendDataToConnectedUser(
        jsonEncode(sendData),
        chatProvider.socket!,
      );

      // await controller.getChatResponse(message: text).then(
      //   (value) {
      //     if (value == null) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           content: Text('Error fetching response'),
      //         ),
      //       );
      //     } else {
      //       chatProvider.getMessageList(value);
      //     }
      //   },
      // );
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
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        var bot = chatProvider.botModel;
        bool isLoading = bot == null && errorString.isEmpty;
        return Scaffold(
          //appBar: AppBar(title: const Text('Chat Screen')),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : errorString.isNotEmpty
                  ? Center(
                      child: Text(
                        errorString,
                      ),
                    )
                  : bot == null
                      ? const Center(
                          child: Text('Failed to initalise bot'),
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                              height: 200,
                              color: getColor(
                                bot.accentColor!,
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: bot.botAvatar!,
                                    height: 100,
                                    width: 100,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    bot.subheading ?? "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Stack(
                                        children: [
                                          const Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: -5,
                                            child: Consumer<CartProvider>(
                                                builder: (context, cartProvider,
                                                    child) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  cartProvider
                                                      .getQuantity()
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const CartView(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Consumer<ChatProvider>(
                                  builder: (context, chatProvider, child) {
                                var messages = chatProvider.messages;
                                return ListView.builder(
                                  //reverse: true,
                                  itemCount: messages.length,
                                  itemBuilder: (context, index) {
                                    var message = messages[index];
                                    return ChatMessage(
                                      onTap:
                                          message.possibleUserResponses.isEmpty
                                              ? null
                                              : _handleSubmitted,
                                      botImage: bot.botAvatar!,
                                      isSender: message.isSender,
                                      text: message.text,
                                      product: message.product,
                                      showLoader: message.showLoader,
                                      possibleUserResponses:
                                          message.possibleUserResponses,
                                    );
                                  },
                                );
                              }),
                            ),
                            // const Divider(height: 1.0),
                            ChatInputBar(
                              color: getColor(
                                bot.accentColor!,
                              ),
                              onSubmitted: _handleSubmitted,
                              onImageSelected: _handleImageSelected,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
        );
      },
    );
  }
}
