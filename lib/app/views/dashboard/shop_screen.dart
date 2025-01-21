import 'package:ezy_shop/app/views/product/product_card.dart';
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
        onChanged: (query) => productController.updateSearchQuery(query),
        onSubmitted: (value) {
          productController.updateSearchQuery(value);
        },
        searchBar: true,
      ),
      body: Obx(
        () => productController.isLoading.value
            ? GFLoader()
            : GridView.builder(
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
