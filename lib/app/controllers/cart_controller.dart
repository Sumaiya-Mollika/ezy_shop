import 'package:ezy_shop/app/models/cart_item.dart';
import 'package:ezy_shop/app/models/product_response.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
final cartItems=RxList<CartItem>([]);

  // Add product to cart
  void addToCart(Products product) {
    final existingItem = cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      cartItems.add(CartItem(product: product, quantity: 1));
    } else {
      existingItem.quantity++;
    }
    cartItems.refresh();
    // update();
  }

  // Remove product from cart
  void removeFromCart(Products product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    cartItems.refresh();
    // update();
  }

  // Update product quantity in cart
  void updateQuantity(CartItem item, int quantity) {
    if (quantity <= item.product.stock! &&
        quantity >= item.product.minimumOrderQuantity!) {
      item.quantity = quantity;
      cartItems.refresh();
      // update();
    }
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
  }
}