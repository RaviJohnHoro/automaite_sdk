// class ChatModel {
//   final Response? data;

//   ChatModel({
//     this.data,
//   });

//   factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
//         data: json["response"] == null
//             ? null
//             : Response.fromJson(json["response"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "response": data?.toJson(),
//       };
// }

// class Response {
//   final ProductData? productData;
//   final int? displayCount;
//   final List<ProductList>? productList;
//   final String? message;

//   Response({
//     this.productData,
//     this.displayCount,
//     this.productList,
//     this.message,
//   });

//   factory Response.fromJson(Map<String, dynamic> json) => Response(
//         productData: json["productData"] == null
//             ? null
//             : ProductData.fromJson(json["productData"]),
//         displayCount: json["displayCount"],
//         productList: json["productList"] == null
//             ? []
//             : List<ProductList>.from(
//                 json["productList"]!.map((x) => ProductList.fromJson(x))),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "productData": productData?.toJson(),
//         "displayCount": displayCount,
//         "productList": productList == null
//             ? []
//             : List<dynamic>.from(productList!.map((x) => x.toJson())),
//         "message": message,
//       };
// }

// class ProductData {
//   final String? productListName;
//   final String? productListDescription;

//   ProductData({
//     this.productListName,
//     this.productListDescription,
//   });

//   factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
//         productListName: json["productListName"],
//         productListDescription: json["productListDescription"],
//       );

//   Map<String, dynamic> toJson() => {
//         "productListName": productListName,
//         "productListDescription": productListDescription,
//       };
// }

// class ProductList {
//   final String? imageUrl;
//   final String? productSpecification;
//   final int? productId;
//   final String? productName;
//   final int? price;
//   final String? buyNowLink;

//   ProductList({
//     this.imageUrl,
//     this.productSpecification,
//     this.productId,
//     this.productName,
//     this.price,
//     this.buyNowLink,
//   });

//   factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
//         imageUrl: json["imageUrl"],
//         productSpecification: json["productSpecification"],
//         productId: json["productId"],
//         productName: json["productName"],
//         price: json["price"],
//         buyNowLink: json["buyNowLink"],
//       );

//   Map<String, dynamic> toJson() => {
//         "imageUrl": imageUrl,
//         "productSpecification": productSpecification,
//         "productId": productId,
//         "productName": productName,
//         "price": price,
//         "buyNowLink": buyNowLink,
//       };
// }
