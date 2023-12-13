class BotModel {
  final String? id;
  final String? userId;
  final String? botName;
  final List<String>? botType;
  final String? companyName;
  final String? botAvatar;
  final String? companyLogo;
  final String? bubbleIcon;
  final String? accentColor;
  final String? subheading;
  final String? welcomeMessage;
  final String? inputPlaceholder;
  final bool? showFloating;
  final String? initialized;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  BotModel({
    this.id,
    this.userId,
    this.botName,
    this.botType,
    this.companyName,
    this.botAvatar,
    this.companyLogo,
    this.bubbleIcon,
    this.accentColor,
    this.subheading,
    this.welcomeMessage,
    this.inputPlaceholder,
    this.showFloating,
    this.initialized,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  BotModel copyWith({
    String? id,
    String? userId,
    String? botName,
    List<String>? botType,
    String? companyName,
    String? botAvatar,
    String? companyLogo,
    String? bubbleIcon,
    String? accentColor,
    String? subheading,
    String? welcomeMessage,
    String? inputPlaceholder,
    bool? showFloating,
    String? initialized,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      BotModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        botName: botName ?? this.botName,
        botType: botType ?? this.botType,
        companyName: companyName ?? this.companyName,
        botAvatar: botAvatar ?? this.botAvatar,
        companyLogo: companyLogo ?? this.companyLogo,
        bubbleIcon: bubbleIcon ?? this.bubbleIcon,
        accentColor: accentColor ?? this.accentColor,
        subheading: subheading ?? this.subheading,
        welcomeMessage: welcomeMessage ?? this.welcomeMessage,
        inputPlaceholder: inputPlaceholder ?? this.inputPlaceholder,
        showFloating: showFloating ?? this.showFloating,
        initialized: initialized ?? this.initialized,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory BotModel.fromJson(Map<String, dynamic> json) => BotModel(
        id: json["_id"],
        userId: json["userId"],
        botName: json["botName"],
        botType: json["botType"] == null
            ? []
            : List<String>.from(json["botType"]!.map((x) => x)),
        companyName: json["companyName"],
        botAvatar: json["botAvatar"],
        companyLogo: json["companyLogo"],
        bubbleIcon: json["bubbleIcon"],
        accentColor: json["accentColor"],
        subheading: json["subheading"],
        welcomeMessage: json["welcomeMessage"],
        inputPlaceholder: json["inputPlaceholder"],
        showFloating: json["showFloating"],
        initialized: json["initialized"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "botName": botName,
        "botType":
            botType == null ? [] : List<dynamic>.from(botType!.map((x) => x)),
        "companyName": companyName,
        "botAvatar": botAvatar,
        "companyLogo": companyLogo,
        "bubbleIcon": bubbleIcon,
        "accentColor": accentColor,
        "subheading": subheading,
        "welcomeMessage": welcomeMessage,
        "inputPlaceholder": inputPlaceholder,
        "showFloating": showFloating,
        "initialized": initialized,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
