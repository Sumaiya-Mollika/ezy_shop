import 'package:ezy_shop/app/controllers/cart_controller.dart';
import 'package:ezy_shop/app/models/product_response.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:ezy_shop/app/views/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../components/text_component.dart';
import '../../utils/constants.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return GestureDetector(
      onTap: () {
        pushWithNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(product: product)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              child: GFImageOverlay(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextComponent(
                        '${CurrencySign.appCurrency} ${product.mrp!.toStringAsFixed(2)}',
                      ),
                      GestureDetector(
                          onTap: () {
                            cartController.showQuantityBottomSheet(product);
                          },
                          child: Icon(
                            Icons.add_box,
                            color: AppColors.primary,
                          ))
                    ],
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
