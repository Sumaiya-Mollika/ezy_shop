import 'dart:developer';

import 'package:ezy_shop/app/utils/style.dart';
import 'package:ezy_shop/app/views/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../controllers/product_controller.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());


    return Scaffold(
      appBar: GFAppBar(
        title: Text("Products"),
        onChanged: (value) => productController.onSearchChanged(value),
        onSubmitted: (value) {
          // log(value);
          productController.onSearchChanged(value);
        },
        searchBar: true,
        actions: <Widget>[
          GFIconButton(
            color: AppColors.primary,
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: Obx(
        () =>productController.isLoading.value?GFLoader(): GridView.builder(
          itemCount: productController.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 240,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final item = productController.products[index];
            return ProductCard(product: item);
          },
        ),
      ),
    );
  }
}
