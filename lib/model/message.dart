class Message {
  final bool isSender;
  final String? text;
  final String? imageUrl;
  //final Function? onTap;

  const Message({
    this.isSender = false,
    this.text,
    this.imageUrl,
    //this.onTap,
  });

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      isSender: map["isSender"],
      text: map["text"],
      imageUrl: map["imageUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isSender": isSender,
      "text": text,
      "imageUrl": imageUrl,
    };
  }
}
