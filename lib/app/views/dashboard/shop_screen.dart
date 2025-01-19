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
    productController.fetchProducts();

    return Scaffold(
      appBar: GFAppBar(
        title: Text("Products"),
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
        () => GridView.builder(
          itemCount: productController.product.value!.products!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 240,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final item = productController.product.value!.products![index];
            return ProductCard(product: item);
          },
        ),
      ),
    );
  }
}
