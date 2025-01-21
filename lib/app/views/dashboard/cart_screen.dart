import 'package:ezy_shop/app/components/app_button.dart';
import 'package:ezy_shop/app/controllers/bottom_nav_controller.dart';
import 'package:ezy_shop/app/utils/constants.dart';
import 'package:ezy_shop/app/utils/util.dart';
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
            var promotionText = getPromotionText(cartItem);

            return Dismissible(
              key: Key(cartItem.product.id.toString()),
              direction: DismissDirection.endToStart,
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
              child: Column(
                children: [
                  GFListTile(
                    avatar: cartItem.product.prouductImages!.isNotEmpty
                        ? GFAvatar(
                            shape: GFAvatarShape.standard,
                            backgroundImage: NetworkImage(
                                cartItem.product.prouductImages!.first.image!))
                        : null,
                    titleText: cartItem.product.title ?? '',
                    subTitleText: promotionText ??
                        '${CurrencySign.appCurrency}${cartItem.product.mrp! * cartItem.quantity}',
                    icon: Expanded(
                      child: SizedBox(
                        width: Get.width * .3,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  child: Icon(Icons.remove, color: Colors.red),
                                  onTap: () {
                                    cartController.decreaseQuantity(cartItem);
                                  },
                                ),
                                TextComponent(
                                  cartItem.quantity.toString(),
                                ),
                                GestureDetector(
                                  child: Icon(Icons.add, color: Colors.green),
                                  onTap: () {
                                    cartController.increaseQuantity(cartItem);
                                  },
                                ),
                              ],
                            ),
                            TextComponent(
                              "Swipe left to remove",
                              fontSize: TextSize.k12FontSize,
                              color: const Color(0xFFC37B7E),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (cartItem.product.promotion != null &&
                      cartItem.product.promotion!.type == PromotionType.gwp &&
                      promotionText != null)
                    GFListTile(
                      avatar: cartItem.product.promotion!.promotionDetails!
                              .first.discountProduct!.productImages!.isNotEmpty
                          ? GFAvatar(
                              shape: GFAvatarShape.standard,
                              backgroundImage: NetworkImage(cartItem
                                  .product
                                  .promotion!
                                  .promotionDetails!
                                  .first
                                  .discountProduct!
                                  .productImages!
                                  .first
                                  .image!))
                          : null,
                      titleText: cartItem.product.promotion!.promotionDetails!
                          .first.discountProduct!.title,
                    )
                ],
              ),
            );
          },
        );
      }),
      persistentFooterButtons: [
        Obx(
          () => cartController.cartItems.isNotEmpty
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent("Subtotal: "),
                        TextComponent(
                            "${CurrencySign.appCurrency} ${cartController.calculateSubtotal(cartController.cartItems)}"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: AppButton(
                        buttonText: "Checkout",
                        onButtonPress: () {},
                      ),
                    )
                  ],
                )
              : SizedBox(),
        ),
      ],
    );
  }
}
