import 'package:ezy_shop/app/controllers/bottom_nav_controller.dart';
import 'package:ezy_shop/app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../../gen/assets.gen.dart';
import '../../components/text_component.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/style.dart';
import '../empty_data_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final navController = Get.put(BottomNavBarController());
    cartController.loadCart();
    return Scaffold(
      appBar: GFAppBar(title: Text('Your Cart')),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return EmptyDataScreen(
            imageUrl: Assets.images.basket.path,
            title: "You don’t have any item in cart yet.",
            buttonText: "Shop Now",
            onTap: () {
              navController.persistentTabController.jumpToTab(0);
            },
          );
        }
        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            var cartItem = cartController.cartItems[index];
            return Dismissible(
              key: Key(cartItem.product.id.toString()),
                 direction: DismissDirection.endToStart, // Swipe direction
              background: Container(
                color: AppColors.kErrorColor,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                cartController.removeFromCart(cartItem); 
                Get.snackbar(
                  'Item Removed',
                  '${cartItem.product.title} has been removed from your cart.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: GFListTile(
                avatar: cartItem.product.prouductImages!.isNotEmpty
                    ? GFAvatar(
                        shape: GFAvatarShape.standard,
                        backgroundImage: NetworkImage(
                            cartItem.product.prouductImages!.first.image!))
                    : null,
                titleText: cartItem.product.title ?? '',
                subTitleText: '৳${cartItem.product.mrp! * cartItem.quantity}',
                icon: SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red),
                        onPressed: () {},
                      ),
                      TextComponent(
                        cartItem.quantity.toString(),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
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
