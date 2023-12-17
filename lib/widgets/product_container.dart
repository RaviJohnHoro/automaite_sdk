import 'package:automaite_android_sdk/model/bot_response_model.dart';
import 'package:automaite_android_sdk/model/product_model.dart';
import 'package:automaite_android_sdk/provider/cart_provider.dart';
import 'package:automaite_android_sdk/provider/chat_provider.dart';
import 'package:automaite_android_sdk/utils/constant.dart';
import 'package:automaite_android_sdk/utils/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductContainer extends StatefulWidget {
  final String imageUrl;
  final ProductList product;

  const ProductContainer({
    required this.product,
    required this.imageUrl,
    super.key,
  });

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  Varient? selectedVarient;

  setVarient(Varient varient) {
    if (mounted) {
      setState(() {
        selectedVarient = varient;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedVarient = widget.product.varient!.first;
  }

  @override
  Widget build(BuildContext context) {
    var bot = Provider.of<ChatProvider>(context, listen: false).botModel!;
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: widget.imageUrl,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  widget.product!.productName ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<Varient>(
              isExpanded: true,
              isDense: false,
              value: selectedVarient,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: widget.product.varient!
                  .map(
                    (e) => DropdownMenuItem<Varient>(
                      value: e,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.varientName ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              //fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "$RUPEE ${e.varientPrice}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              //fontSize: 16,
                            ),
                          ),
                          //const Divider(),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          // Wrap(
          //   children: widget.product.varient!
          //       .map(
          //         (e) => Container(
          //           padding: const EdgeInsets.all(5),
          //           margin: const EdgeInsets.all(5),
          //           decoration: BoxDecoration(
          //             border: Border.all(),
          //           ),
          //           child: Text(
          //             e.varientName ?? "",
          //           ),
          //         ),
          //       )
          //       .toList(),
          // ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: getColor(
                  bot.accentColor!,
                ),
              ),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addProduct(ProductModel(
                  productId: widget.product.id!,
                  variantId: selectedVarient!.varientId!.toString(),
                  variantName: selectedVarient!.varientName!,
                  quantity: 1,
                ));
              },
              child: const Text('Add to Cart'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
