import 'product_response.dart';

class CartItem {
  final Products product;
  int quantity;

  CartItem({required this.product, required this.quantity});
    // Factory method to create a CartItem from a JSON map
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Products.fromJson(json['product']),  // Ensure Products also has a fromJson method
      quantity: json['quantity'],
    );
  }

  // Method to convert a CartItem to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),  // Ensure Products also has a toJson method
      'quantity': quantity,
    };
  }
}