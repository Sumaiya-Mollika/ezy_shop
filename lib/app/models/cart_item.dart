import 'product_response.dart';

class CartItem {
  final Products product;
  int quantity;
  bool isFree;  // Flag to indicate if this is a free product
  int? linkedProductId;  // ID of the product that the free product is linked to

  CartItem({
    required this.product,
    required this.quantity,
    this.isFree = false,  // Default value is false
    this.linkedProductId,
  });

  // Factory method to create a CartItem from a JSON map
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Products.fromJson(json['product']),  // Ensure Products also has a fromJson method
      quantity: json['quantity'],
      isFree: json['isFree'] ?? false,  // Default to false if not provided
      linkedProductId: json['linkedProductId'],
    );
  }

  // Method to convert a CartItem to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),  // Ensure Products also has a toJson method
      'quantity': quantity,
      'isFree': isFree,
      'linkedProductId': linkedProductId,
    };
  }
}
