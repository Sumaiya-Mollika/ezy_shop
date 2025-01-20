
import 'package:ezy_shop/app/models/cart_item.dart';
import 'package:ezy_shop/app/models/product_response.dart';
import 'package:ezy_shop/app/utils/constants.dart';
import 'package:get/get.dart';
import '../views/quantity_bottom_sheet.dart';


class CartController extends GetxController {
  // Reactive list of CartItems
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

  // Save cart items to GetStorage
  Future<void> _saveCart() async {
    final savedCart = cartItems.map((e) => e.toJson()).toList();
    await storage.write(StorageKey.cartItems, savedCart);
  }


  // Add product to cart
  void addToCart(Products product, int quantity) {
    var existingItem = cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      existingItem.quantity += quantity;
      existingItem.quantity = _applyQuantityLimit(existingItem);
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
    _saveCart();
  }

  // Increment/decrement quantity with validation
  void changeQuantity(CartItem item, int change) {
    item.quantity += change;
    item.quantity = _applyQuantityLimit(item);
    _saveCart();
  }
  // Apply stock and minimum order quantity validation
// Apply stock and minimum order quantity validation
int _applyQuantityLimit(CartItem item) {
  // Check minimum order quantity
  int minOrderQuantity = item.product.minimumOrderQuantity ?? 1;
  int stock = item.product.stock ?? 0;

  // Ensure the quantity is within the limits
  if (item.quantity < minOrderQuantity) {
    return minOrderQuantity;
  }
  if (item.quantity > stock) {
    return stock;
  }
  return item.quantity;
}

  // Calculate total price and discount
  double calculateTotal() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.product.mrp! * item.quantity;
    }
    return total;
  }

  // Add product to cart
  // void addToCart(Products product, int quantity) {
  //   final maxQuantity = product.stock ?? 0;
  //   final minOrderQuantity = product.minimumOrderQuantity ?? 1;

  //   if (quantity < minOrderQuantity) {
  //     Get.snackbar('Error', 'Minimum order quantity is $minOrderQuantity');
  //     return;
  //   }

  //   if (quantity > maxQuantity) {
  //     Get.snackbar('Error', 'Quantity exceeds available stock ($maxQuantity)');
  //     return;
  //   }

  //   // Check if the product is already in the cart
  //   final existingCartItem = cartItems.firstWhereOrNull(
  //     (cartItem) => cartItem.product.id == product.id,
  //   );

  //   if (existingCartItem != null) {
  //     // If the product is already in the cart, increment its quantity
  //     existingCartItem.quantity += quantity;
  //     cartItems.refresh();
  //   } else {
  //     // Add new CartItem to the cart
  //     cartItems.add(CartItem(product: product, quantity: quantity));
  //   }

  //   // Optionally show the bottom sheet for quantity adjustment
  //   showQuantityBottomSheet(product);
  //    _saveCart();
  // }

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
     _saveCart();
  }

  // Calculate total price of the cart
  double getTotalPrice() {
    return cartItems.fold(
      0.0,
      (total, cartItem) => total + (cartItem.product.mrp ?? 0) * cartItem.quantity,
    );
  }
}
