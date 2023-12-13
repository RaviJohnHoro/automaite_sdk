class BotResponseModel {
  final String? identity;
  final List<ProductList>? productList;
  final String? message;
  final String? roomId;
  final bool? agentTalk;
  final List<String>? possibleUserResponses;

  BotResponseModel({
    this.identity,
    this.productList,
    this.message,
    this.roomId,
    this.agentTalk,
    this.possibleUserResponses,
  });

  BotResponseModel copyWith({
    String? identity,
    List<ProductList>? productList,
    String? message,
    String? roomId,
    bool? agentTalk,
    List<String>? possibleUserResponses,
  }) =>
      BotResponseModel(
        identity: identity ?? this.identity,
        productList: productList ?? this.productList,
        message: message ?? this.message,
        roomId: roomId ?? this.roomId,
        agentTalk: agentTalk ?? this.agentTalk,
        possibleUserResponses:
            possibleUserResponses ?? this.possibleUserResponses,
      );

  factory BotResponseModel.fromJson(Map<String, dynamic> json) =>
      BotResponseModel(
        identity: json["identity"],
        productList: json["productList"] == null
            ? []
            : List<ProductList>.from(
                json["productList"]!.map((x) => ProductList.fromJson(x))),
        message: json["message"],
        roomId: json["roomId"],
        agentTalk: json["agentTalk"],
        possibleUserResponses: json["possibleUserResponses"] == null
            ? []
            : List<String>.from(json["possibleUserResponses"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "identity": identity,
        "productList": productList == null
            ? []
            : List<dynamic>.from(productList!.map((x) => x.toJson())),
        "message": message,
        "roomId": roomId,
        "agentTalk": agentTalk,
        "possibleUserResponses": possibleUserResponses == null
            ? []
            : List<dynamic>.from(possibleUserResponses!.map((x) => x)),
      };
}

class ProductList {
  final String? id;
  final String? userId;
  final String? storeId;
  final String? productId;
  final String? productName;
  final String? productDescription;
  final String? price;
  final List<Varient>? varient;
  final String? productSku;
  final bool? hasVarient;
  final List<dynamic>? relatedProducts;
  final List<String>? images;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductList({
    this.id,
    this.userId,
    this.storeId,
    this.productId,
    this.productName,
    this.productDescription,
    this.price,
    this.varient,
    this.productSku,
    this.hasVarient,
    this.relatedProducts,
    this.images,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  ProductList copyWith({
    String? id,
    String? userId,
    String? storeId,
    String? productId,
    String? productName,
    String? productDescription,
    String? price,
    List<Varient>? varient,
    String? productSku,
    bool? hasVarient,
    List<dynamic>? relatedProducts,
    List<String>? images,
    int? v,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ProductList(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        storeId: storeId ?? this.storeId,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productDescription: productDescription ?? this.productDescription,
        price: price ?? this.price,
        varient: varient ?? this.varient,
        productSku: productSku ?? this.productSku,
        hasVarient: hasVarient ?? this.hasVarient,
        relatedProducts: relatedProducts ?? this.relatedProducts,
        images: images ?? this.images,
        v: v ?? this.v,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        id: json["_id"],
        userId: json["userId"],
        storeId: json["storeId"],
        productId: json["productId"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        price: json["price"],
        varient: json["varient"] == null
            ? []
            : List<Varient>.from(
                json["varient"]!.map((x) => Varient.fromJson(x))),
        productSku: json["productSku"],
        hasVarient: json["hasVarient"],
        relatedProducts: json["relatedProducts"] == null
            ? []
            : List<dynamic>.from(json["relatedProducts"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        v: json["__v"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "storeId": storeId,
        "productId": productId,
        "productName": productName,
        "productDescription": productDescription,
        "price": price,
        "varient": varient == null
            ? []
            : List<dynamic>.from(varient!.map((x) => x.toJson())),
        "productSku": productSku,
        "hasVarient": hasVarient,
        "relatedProducts": relatedProducts == null
            ? []
            : List<dynamic>.from(relatedProducts!.map((x) => x)),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Varient {
  final String? varientName;
  final int? varientId;
  final String? varientPrice;
  final String? varientSku;

  Varient({
    this.varientName,
    this.varientId,
    this.varientPrice,
    this.varientSku,
  });

  Varient copyWith({
    String? varientName,
    int? varientId,
    String? varientPrice,
    String? varientSku,
  }) =>
      Varient(
        varientName: varientName ?? this.varientName,
        varientId: varientId ?? this.varientId,
        varientPrice: varientPrice ?? this.varientPrice,
        varientSku: varientSku ?? this.varientSku,
      );

  factory Varient.fromJson(Map<String, dynamic> json) => Varient(
        varientName: json["varientName"],
        varientId: json["varientId"],
        varientPrice: json["varientPrice"],
        varientSku: json["varientSku"],
      );

  Map<String, dynamic> toJson() => {
        "varientName": varientName,
        "varientId": varientId,
        "varientPrice": varientPrice,
        "varientSku": varientSku,
      };
}
