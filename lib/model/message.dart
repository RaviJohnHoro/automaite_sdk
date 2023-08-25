class Message {
  final String? text;
  final String? imageUrl;
  final bool isSender;

  const Message({
    this.text,
    this.imageUrl,
    required this.isSender,
  });
}
