import 'package:automaite_android_sdk/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            var products = cartProvider.products;
            return ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(product.variantName),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            product.quantity.toString(),
                            style: const TextStyle(
                              //fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Go to cart',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
