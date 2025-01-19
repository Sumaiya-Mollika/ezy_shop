import 'package:ezy_shop/app/models/product_response.dart';
import 'package:ezy_shop/app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../components/text_component.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showQuantityBottomSheet(context,product);
        // Get.to(() => ProductDetailsScreen(product: product),
        //     transition: rightToLeft);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              child: GFImageOverlay(
                image: NetworkImage(product.prouductImages!.first.image!),
              ),
            ),
       
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                    product.title!,
                    // fontWeight: titleFontWeight,
                    // fontSize: k14FontSize,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 4),
                  TextComponent(
                    'BDT ${product.mrp!.toStringAsFixed(2)}',
                   // fontSize: k12FontSize,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
