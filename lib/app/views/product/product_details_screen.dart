import 'package:ezy_shop/app/models/product_response.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:ezy_shop/app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../components/text_component.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Products? product;
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Scaffold(
      appBar: GFAppBar(
        title: TextComponent(
          product!.title!,
          color: AppColors.kWhiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GFCarousel(
                enableInfiniteScroll: false,
                activeIndicator: AppColors.primary,
                passiveIndicator: AppColors.kGrayColor,
                items: product!.prouductImages!.map(
                  (item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showImageDialog(
                              context, product!.title!, item.image!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(
                            item.image!,
                            fit: BoxFit.cover,
                            width: Get.width,
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
                onPageChanged: (index) {},
              ),
              Row(
                children: [
                  TextComponent(
                    "Product Name: ",
                    textAlign: TextAlign.start,
                  ),
                  TextComponent(
                    product!.title,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Row(
                children: [
                  TextComponent(
                    "Weight: ",
                    textAlign: TextAlign.start,
                  ),
                  TextComponent(
                    "${product!.weight} ${product!.weightUnit}",
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Row(
                children: [
                  TextComponent(
                    "Stock: ",
                    textAlign: TextAlign.start,
                  ),
                  TextComponent(
                    "${product!.stock != 0 ? product!.stock : 'Out of Stock'}",
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextComponent(
                        "Price: ",
                        textAlign: TextAlign.start,
                      ),
                      TextComponent(
                        "${CurrencySign.appCurrency} ${product!.mrp}",
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  GFButton(
                    color: AppColors.primary,
                    onPressed: () {
                      cartController.showQuantityBottomSheet(product!);
                    },
                    child: TextComponent(
                      "Buy",
                      color: AppColors.kWhiteColor,
                    ),
                  )
                ],
              ),
              if (product!.promotion != null) getPromotion(product!.promotion!),
            ],
          ),
        ),
      ),
    );
  }
}
