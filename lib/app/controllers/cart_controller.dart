import 'package:ezy_shop/app/models/cart_item.dart';
import 'package:ezy_shop/app/models/product_response.dart';
import 'package:ezy_shop/app/utils/constants.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:get/get.dart';
import '../views/product/quantity_bottom_sheet.dart';

class CartController extends GetxController {
  final RxList<CartItem> cartItems = RxList<CartItem>([]);

  @override
  void onInit() {
    loadCart();
    super.onInit();
  }

  Future<void> loadCart() async {
    final savedCart = storage.read<List>(StorageKey.cartItems) ?? [];
    cartItems.value = savedCart.map((e) => CartItem.fromJson(e)).toList();
  }

  Future<void> _saveCart() async {
    final savedCart = cartItems.map((e) => e.toJson()).toList();
    await storage.write(StorageKey.cartItems, savedCart);
  }

  void addToCart(Products product, int quantity) {
    var existingItem =
        cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      existingItem.quantity += quantity;
      existingItem.quantity = _applyQuantityLimit(existingItem);
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
    _saveCart();
  }

  // Method to decrease quantity
  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > cartItem.product.minimumOrderQuantity!) {
      cartItem.quantity--;
      cartItems.refresh();
      _saveCart();
    } else {
      Get.snackbar('Error',
          'Minimum quantity is ${cartItem.product.minimumOrderQuantity!}',
          backgroundColor: AppColors.kErrorColor.withValues(alpha: 0.4));
    }
  }

  // Method to increase quantity
  void increaseQuantity(CartItem cartItem) {
    int maxQuantity = cartItem.product.stock ?? 0;
    if (cartItem.quantity < maxQuantity) {
      cartItem.quantity++;
      cartItems.refresh();
      _saveCart();
    } else {
      Get.snackbar('Error', 'Quantity exceeds available stock.',
          backgroundColor: AppColors.kErrorColor.withValues(alpha: 0.4));
    }
  }

  int _applyQuantityLimit(CartItem item) {
    int minOrderQuantity = item.product.minimumOrderQuantity ?? 1;
    int stock = item.product.stock ?? 0;

    if (item.quantity < minOrderQuantity) {
      return minOrderQuantity;
    }
    if (item.quantity > stock) {
      return stock;
    }
    return item.quantity;
  }

  void removeFromCart(CartItem cartItem) {
    cartItems.remove(cartItem);
    _saveCart();
  }

  // Show quantity bottom sheet for adjusting product quantity
  void showQuantityBottomSheet(Products product) {
    Get.bottomSheet(
      QuantityBottomSheet(product: product),
      isScrollControlled: true,
    );
  }
}
