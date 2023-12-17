class ProductModel {
  final String productId;
  final String variantId;
  final String variantName;
  final int quantity;

  const ProductModel({
    required this.productId,
    required this.variantId,
    required this.variantName,
    required this.quantity,
  });

  ProductModel copyWith({
    String? productId,
    String? variantId,
    String? variantName,
    int? quantity,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
      quantity: quantity ?? this.quantity,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'variantId': variantId,
      'variantName': variantName,
      'quantity': quantity,
    };
  }
}
