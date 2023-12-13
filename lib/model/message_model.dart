// class MessageModel {
//   final bool? isProduct;
//   final bool? isProductList;
//   final ProductData? productData;
//   final int? displayCount;
//   final List<ProductList>? productList;
//   final String? message;
//   final bool isSender;

//   const MessageModel({
//     this.isProduct,
//     this.isProductList,
//     this.productData,
//     this.displayCount,
//     this.productList,
//     this.message,
//     this.isSender = false,
//   });

//   factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
//         isProduct: json["isProduct"],
//         isProductList: json["isProductList"],
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
//         "isProduct": isProduct,
//         "isProductList": isProductList,
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
//   final String? ratings;
//   final int? productId;
//   final String? productName;
//   final int? price;

//   ProductList({
//     this.imageUrl,
//     this.ratings,
//     this.productId,
//     this.productName,
//     this.price,
//   });

//   factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
//         imageUrl: json["imageUrl"],
//         ratings: json["ratings"],
//         productId: json["productId"],
//         productName: json["productName"],
//         price: json["price"],
//       );

//   Map<String, dynamic> toJson() => {
//         "imageUrl": imageUrl,
//         "ratings": ratings,
//         "productId": productId,
//         "productName": productName,
//         "price": price,
//       };
// }
