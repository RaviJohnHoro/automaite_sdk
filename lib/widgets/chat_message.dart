import 'package:automaite_android_sdk/model/bot_response_model.dart';
import 'package:automaite_android_sdk/provider/chat_provider.dart';
import 'package:automaite_android_sdk/utils/helper_functions.dart';
import 'package:automaite_android_sdk/widgets/lottie_container.dart';
import 'package:automaite_android_sdk/widgets/product_container.dart';
import 'package:automaite_android_sdk/widgets/suggestion_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String botImage;
  final String? text;
  //final String? imageUrl;
  final bool showLoader;
  final bool isSender;
  final ProductList? product;
  final List<String> possibleUserResponses;
  final Function(String)? onTap;

  const ChatMessage({
    required this.botImage,
    this.text,
    //this.imageUrl,
    required this.showLoader,
    this.onTap,
    required this.isSender,
    this.product,
    this.possibleUserResponses = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = product == null ? "" : product!.images!.first;
    var bot = Provider.of<ChatProvider>(context, listen: false).botModel!;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: possibleUserResponses.isNotEmpty
            ? SuggestionContainer(
                onTap: onTap,
                possibleUserResponses: possibleUserResponses,
                color: getColor(
                  bot.accentColor!,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: showLoader
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  !isSender
                      ? CachedNetworkImage(
                          imageUrl: botImage,
                          height: 40,
                          width: 40,
                        )
                      : Container(),
                  !isSender
                      ? const SizedBox(
                          width: 10,
                        )
                      : Container(),
                  Flexible(
                    child: Container(
                      padding: showLoader || imageUrl.isNotEmpty
                          ? null
                          : const EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: showLoader
                          ? const LottieContainer()
                          : imageUrl.isEmpty
                              ? Text(text ?? "")
                              : ProductContainer(
                                  product: product!,
                                  imageUrl: imageUrl,
                                ),
                    ),
                  ),
                  isSender
                      ? const SizedBox(
                          width: 10,
                        )
                      : Container(),
                  isSender
                      ? const Icon(
                          Icons.person,
                          size: 30,
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}
