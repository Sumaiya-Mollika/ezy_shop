import 'product_response.dart';

class CartItem {
  final Products product;
  int quantity;
  double?priceAfterDiscount;

  CartItem({
    required this.product,
    required this.quantity,
    this.priceAfterDiscount,

  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Products.fromJson(
          json['product']),
      quantity: json['quantity'],
      priceAfterDiscount: json['priceAfterDiscount'], 
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(), 
      'quantity': quantity,
      'priceAfterDiscount': priceAfterDiscount,
      
    };
  }
}
