import 'dart:developer';

import 'package:automaite_android_sdk/model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> products = [];

  addProduct(ProductModel product) {
    bool containsProduct = false;
    for (var e in products) {
      if (e.productId == product.productId &&
          e.variantId == product.variantId) {
        var quantity = product.quantity + e.quantity;
        log("quantity is: ${product.quantity} ${product.quantity} $quantity");
        products[products.indexOf(e)] = e.copyWith(quantity: quantity);
        log("quant: ${e.quantity}");
        containsProduct = true;
        break;
      }
    }
    if (!containsProduct) {
      products.add(product);
    }
    notifyListeners();
  }

  getQuantity() {
    int quantity = 0;
    for (var e in products) {
      quantity += e.quantity;
    }
    return quantity;
  }
}
