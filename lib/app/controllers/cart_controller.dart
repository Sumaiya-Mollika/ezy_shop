// import 'package:ezy_shop/app/models/cart_item.dart';
// import 'package:ezy_shop/app/models/product_response.dart';
// import 'package:get/get.dart';

// class CartController extends GetxController {
// final cartItems=RxList<CartItem>([]);

//   // Add product to cart
//   void addToCart(Products product) {
//     final existingItem = cartItems.firstWhere(
//       (item) => item.product.id == product.id,
//       orElse: () => CartItem(product: product, quantity: 0),
//     );

//     if (existingItem.quantity == 0) {
//       cartItems.add(CartItem(product: product, quantity: 1));
//     } else {
//       existingItem.quantity++;
//     }
//     cartItems.refresh();
//     // update();
//   }

//   // Remove product from cart
//   void removeFromCart(Products product) {
//     cartItems.removeWhere((item) => item.product.id == product.id);
//     cartItems.refresh();
//     // update();
//   }

//   // Update product quantity in cart
//   void updateQuantity(CartItem item, int quantity) {
//     if (quantity <= item.product.stock! &&
//         quantity >= item.product.minimumOrderQuantity!) {
//       item.quantity = quantity;
//       cartItems.refresh();
//       // update();
//     }
//   }

//   // Clear cart
//   void clearCart() {
//     cartItems.clear();
//   }
// }




import 'package:ezy_shop/app/models/cart_item.dart';
import 'package:ezy_shop/app/models/product_response.dart';
import 'package:get/get.dart';

import '../views/quantity_bottom_sheet.dart';


class CartController extends GetxController {
  // Reactive list of CartItems
  final RxList<CartItem> cartItems = RxList<CartItem>([]);

  // Add product to cart
  void addToCart(Products product, int quantity) {
    final maxQuantity = product.stock ?? 0;
    final minOrderQuantity = product.minimumOrderQuantity ?? 1;

    if (quantity < minOrderQuantity) {
      Get.snackbar('Error', 'Minimum order quantity is $minOrderQuantity');
      return;
    }

    if (quantity > maxQuantity) {
      Get.snackbar('Error', 'Quantity exceeds available stock ($maxQuantity)');
      return;
    }

    // Check if the product is already in the cart
    final existingCartItem = cartItems.firstWhereOrNull(
      (cartItem) => cartItem.product.id == product.id,
    );

    if (existingCartItem != null) {
      // If the product is already in the cart, increment its quantity
      existingCartItem.quantity += quantity;
      cartItems.refresh();
    } else {
      // Add new CartItem to the cart
      cartItems.add(CartItem(product: product, quantity: quantity));
    }

    // Optionally show the bottom sheet for quantity adjustment
    showQuantityBottomSheet(product);
  }

  // Show quantity bottom sheet for adjusting product quantity
  void showQuantityBottomSheet(Products product) {
    Get.bottomSheet(
      QuantityBottomSheet(product: product), 
      isScrollControlled: true,
    );
  }

  // Remove product from the cart
  void removeFromCart(CartItem cartItem) {
    cartItems.remove(cartItem);
  }

  // Calculate total price of the cart
  double getTotalPrice() {
    return cartItems.fold(
      0.0,
      (total, cartItem) => total + (cartItem.product.mrp ?? 0) * cartItem.quantity,
    );
  }
}
