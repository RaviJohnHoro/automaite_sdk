import 'package:automaite_android_sdk/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  var platform = const MethodChannel('data_channel');

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
                  onPressed: () async {
                    try {
                      await platform.invokeMethod('sendDataToAndroid', {
                        "products":
                            Provider.of<CartProvider>(context, listen: false)
                                .products
                                .map((product) => product.toJson())
                                .toList(),
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Failed: ${e.toString()}',
                          ),
                        ),
                      );
                    }
                  },
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
