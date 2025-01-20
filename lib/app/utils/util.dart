// import 'dart:developer';

// import 'package:ezy_shop/app/controllers/cart_controller.dart';
// import 'package:ezy_shop/app/models/cart_item.dart';
// import 'package:ezy_shop/app/models/product_response.dart';
// import 'package:ezy_shop/app/utils/style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void showQuantityBottomSheet(BuildContext context, Products product) {
//   final cartController = Get.put(CartController());
//   final selectedQuantity = RxInt(1); // Reactive variable
//   final minQuantity = product.minimumOrderQuantity ?? 1;
//   final maxQuantity = product.stock ?? 0;

//   // Calculate bottom sheet height based on screen size
//   final bottomSheetHeight = MediaQuery.of(context).size.height * 0.6;

//   Get.bottomSheet(
//     Container(
//       padding: const EdgeInsets.all(16),
//       height: bottomSheetHeight,
//       child: SingleChildScrollView(
//         child: _buildBottomSheetContent(
//           context,
//           product,
//           selectedQuantity,
//           minQuantity,
//           maxQuantity,
//           cartController,
//         ),
//       ),
//     ),
//   );
// }

// Widget _buildBottomSheetContent(
//   BuildContext context,
//   Products product,
//   RxInt selectedQuantity,
//   int minQuantity,
//   int maxQuantity,
//   CartController cartController,
// ) {
//   return Container(
//     padding: const EdgeInsets.all(16),
//     color: AppColors.scaffoldBackgroundLight,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildProductTitle(product, context),
//         const SizedBox(height: 16),
//         if (product.promotion != null) _buildPromotionText(product),
//         const SizedBox(height: 16),
//         _buildPriceText(product, context),
//         const SizedBox(height: 16),
//         _buildQuantitySelection(
//           selectedQuantity,
//           minQuantity,
//           maxQuantity,
//           cartController,
//           product,
//         ),
//         const SizedBox(height: 16),
//         _buildAddToCartButton(cartController, product, selectedQuantity.value),
//       ],
//     ),
//   );
// }

// Widget _buildProductTitle(Products product, BuildContext context) {
//   return Text(product.title ?? "Product");
// }

// Widget _buildPromotionText(Products product) {
//   return Text(
//     "Promo: ${product.promotion?.title ?? 'No Promotion'}",
//     style: const TextStyle(color: Colors.red),
//   );
// }

// Widget _buildPriceText(Products product, BuildContext context) {
//   return Text("Price: BDT ${product.mrp!.toStringAsFixed(2)}");
// }

// Widget _buildQuantitySelection(
//   RxInt selectedQuantity,
//   int minQuantity,
//   int maxQuantity,
//   CartController cartController,
//   Products product,
// ) {
//   return Row(
//     children: [
//       _buildDecrementButton(
//           selectedQuantity, minQuantity, cartController, product),
//       _buildQuantityTextField(selectedQuantity, minQuantity, maxQuantity),
//       _buildIncrementButton(
//           selectedQuantity, maxQuantity, cartController, product),
//     ],
//   );
// }

// Widget _buildDecrementButton(
//   RxInt selectedQuantity,
//   int minQuantity,
//   CartController cartController,
//   Products product,
// ) {
//   return IconButton(
//     icon: const Icon(Icons.remove),
//     onPressed: () {
//       if (selectedQuantity.value > minQuantity) {
//         selectedQuantity.value--;
//         cartController.updateQuantity(
//           CartItem(product: product, quantity: selectedQuantity.value),
//           selectedQuantity.value,
//         );
//       }
//     },
//   );
// }

// Widget _buildIncrementButton(
//   RxInt selectedQuantity,
//   int maxQuantity,
//   CartController cartController,
//   Products product,
// ) {
//   return IconButton(
//     icon: const Icon(Icons.add),
//     onPressed: () {
//       if (selectedQuantity.value < maxQuantity) {
//         selectedQuantity.value++;
//         cartController.updateQuantity(
//           CartItem(product: product, quantity: selectedQuantity.value),
//           selectedQuantity.value,
//         );
//       }
//     },
//   );
// }

// Widget _buildQuantityTextField(
//   RxInt selectedQuantity,
//   int minQuantity,
//   int maxQuantity,
// ) {
//   final controller =
//       TextEditingController(text: selectedQuantity.value.toString());

//   return Expanded(
//     child: Obx(
//       () {
//         if (controller.text != selectedQuantity.value.toString()) {
//           controller.text = selectedQuantity.value.toString();
//           controller.selection = TextSelection.fromPosition(
//             TextPosition(offset: controller.text.length),
//           );
//         }
//         log(minQuantity.toString());
//         log(maxQuantity.toString());
//         return TextField(
//           keyboardType: TextInputType.number,
//           controller: controller,
//           onChanged: (value) {
//             final quantity = int.tryParse(value);
//             if (quantity != null &&
//                 quantity >= minQuantity &&
//                 quantity <= maxQuantity) {
//               selectedQuantity.value = quantity;
//             }
//           },
//           decoration: const InputDecoration(labelText: "Quantity"),
//         );
//       },
//     ),
//   );
// }

// Widget _buildAddToCartButton(
//   CartController cartController,
//   Products product,
//   int selectedQuantity,
// ) {
//   return ElevatedButton(
//     onPressed: () {
//       cartController.addToCart(
//         product,
//       );
//       Get.back(); // Close the bottom sheet
//     },
//     child: const Text('Add to Cart'),
//   );
// }
