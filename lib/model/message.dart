import 'package:automaite_android_sdk/model/bot_response_model.dart';

class Message {
  final bool isSender;
  final String? text;
  final ProductList? product;
  final List<String> possibleUserResponses;
  final bool showLoader;
  //final String? imageUrl;
  //final Function? onTap;

  const Message({
    this.isSender = false,
    this.text,
    this.product,
    this.possibleUserResponses = const [],
    this.showLoader = false,
    //this.imageUrl,
    //this.onTap,
  });

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      isSender: map["isSender"],
      text: map["text"],
      product: map["product"],
      showLoader: map["showLoader"] ?? false,
      possibleUserResponses: map["possibleUserResponses"] == null
          ? []
          : List<String>.from(map["possibleUserResponses"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isSender": isSender,
      "text": text,
      "product": product?.toJson(),
      "showLoader": showLoader,
      "possibleUserResponses": possibleUserResponses.toString(),
    };
  }
}
