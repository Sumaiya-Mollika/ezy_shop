import 'package:ezy_shop/app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    cartController.loadCart();
    return Scaffold(
      appBar: GFAppBar(title: Text('Your Cart')),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text('No items in the cart'));
        }
        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            var cartItem = cartController.cartItems[index];
            return ListTile(
              title: Text(cartItem.product.title ?? ''),
              subtitle: Text('Qty: ${cartItem.quantity}'),
              trailing: Text('৳${cartItem.product.mrp! * cartItem.quantity}'),
              onTap: () {
                _showQuantityBottomSheet(cartItem);
              },
            );
          },
        );
      }),
    );
  }

  void _showQuantityBottomSheet(CartItem cartItem) {
    Get.bottomSheet(
      QuantityBottomSheet(cartItem: cartItem),
      isScrollControlled: true,
    );
  }
}

class QuantityBottomSheet extends StatelessWidget {
  final CartItem cartItem;

  QuantityBottomSheet({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(cartItem.product.title ?? ''),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  //  cartController.changeQuantity(cartItem, -1);
                },
              ),
              Text('${cartItem.quantity}'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  //  Get.find<CartController>().changeQuantity(cartItem, 1);
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
