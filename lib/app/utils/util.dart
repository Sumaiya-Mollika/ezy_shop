import 'package:ezy_shop/app/models/cart_item.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product_response.dart';

void showQuantityBottomSheet(BuildContext context, Products product) {
  final cartController = Get.put(CartController());
  int selectedQuantity = 1; // Default to minimum quantity
  final minQuantity = product.minimumOrderQuantity ?? 1;
  final maxQuantity = product.stock ?? 0;
  // Get screen height and calculate the bottom sheet height
  double screenHeight = MediaQuery.of(context).size.height;
  double bottomSheetHeight = screenHeight * 0.6; // Adjust as needed

  Get.bottomSheet(
    Container(
  
        padding: const EdgeInsets.all(16),
      height: bottomSheetHeight, 
      child: SingleChildScrollView(
        child: _buildBottomSheetContent(
          context,
          product,
          selectedQuantity,
          minQuantity,
          maxQuantity,
          cartController,
        ),
      ),
    ),
  );
}

Widget _buildBottomSheetContent(
  BuildContext context,
  Products product,
  int selectedQuantity,
  int minQuantity,
  int maxQuantity,
  CartController cartController,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    color: AppColors.scaffoldBackgroundLight
    ,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductTitle(product, context),
        const SizedBox(height: 16),
        if (product.promotion != null) _buildPromotionText(product),
        const SizedBox(height: 16),
        _buildPriceText(product, context),
        const SizedBox(height: 16),
        _buildQuantitySelection(
          selectedQuantity,
          minQuantity,
          maxQuantity,
          cartController,
          product,
        ),
        const SizedBox(height: 16),
        _buildAddToCartButton(cartController, product),
      ],
    ),
  );
}

Widget _buildProductTitle(Products product, BuildContext context) {
  return Text(
    product.title ?? "Product",
   // style: Theme.of(context).textTheme.headline6,
  );
}

Widget _buildPromotionText(Products product) {
  return Text(
    "Promo: ${product.promotion?.title ?? 'No Promotion'}",
    style: TextStyle(color: Colors.red),
  );
}

Widget _buildPriceText(Products product, BuildContext context) {
  return Text(
    "Price: BDT ${product.mrp!.toStringAsFixed(2)}",
   // style: Theme.of(context).textTheme.subtitle1,
  );
}

Widget _buildQuantitySelection(
  int selectedQuantity,
  int minQuantity,
  int maxQuantity,
  CartController cartController,
  Products product,
) {
  return Row(
    children: [
      _buildDecrementButton(
        selectedQuantity,
        minQuantity,
        cartController,
        product,
      ),
      _buildQuantityTextField(
        selectedQuantity,
        minQuantity,
        maxQuantity,
      ),
      _buildIncrementButton(
        selectedQuantity,
        maxQuantity,
        cartController,
        product,
      ),
    ],
  );
}

Widget _buildDecrementButton(
  int selectedQuantity,
  int minQuantity,
  CartController cartController,
  Products product,
) {
  return IconButton(
    icon: const Icon(Icons.remove),
    onPressed: () {
      if (selectedQuantity > minQuantity) {
        selectedQuantity--;
        cartController.updateQuantity(
          CartItem(product: product, quantity: selectedQuantity),
          selectedQuantity,
        );
      }
    },
  );
}

Widget _buildIncrementButton(
  int selectedQuantity,
  int maxQuantity,
  CartController cartController,
  Products product,
) {
  return IconButton(
    icon: const Icon(Icons.add),
    onPressed: () {
      if (selectedQuantity < maxQuantity) {
        selectedQuantity++;
        cartController.updateQuantity(
          CartItem(product: product, quantity: selectedQuantity),
          selectedQuantity,
        );
      }
    },
  );
}

Widget _buildQuantityTextField(
  int selectedQuantity,
  int minQuantity,
  int maxQuantity,
) {
  return Expanded(
    child: TextField(
      keyboardType: TextInputType.number,
      controller: TextEditingController(text: selectedQuantity.toString()),
      onChanged: (value) {
        final quantity = int.tryParse(value);
        if (quantity != null &&
            quantity >= minQuantity &&
            quantity <= maxQuantity) {
          selectedQuantity = quantity;
        }
      },
      decoration: const InputDecoration(labelText: "Quantity"),
    ),
  );
}

Widget _buildAddToCartButton(CartController cartController, Products product) {
  return ElevatedButton(
    onPressed: () {
      cartController.addToCart(product);
      Get.back(); // Close bottom sheet
    },
    child: const Text('Add to Cart'),
  );
}