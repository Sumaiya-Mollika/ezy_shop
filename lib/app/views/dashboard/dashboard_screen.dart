import 'package:ezy_shop/app/utils/style.dart';
import 'package:ezy_shop/app/views/dashboard/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../controllers/bottom_nav_controller.dart';
import '../../controllers/cart_controller.dart';
import 'shop_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavBarController());
  final cartController = Get.put(CartController());
    return GetBuilder<BottomNavBarController>(
      builder: (controller) {
        return PersistentTabView(
          tabs: [
            PersistentTabConfig(
              screen: ShopScreen(),
              item: ItemConfig(
                activeForegroundColor: AppColors.primary,
                icon: Icon(Icons.home),
                title: "Shop",
              ),
            ),
            PersistentTabConfig(
              screen: CartScreen(),
              item: ItemConfig(
                  activeForegroundColor: AppColors.primary,
                  icon:  
                    // Icon(
                    //       Icons.shopping_basket,),
                   Obx(() {
                    return AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child:
                             cartController.cartItems.isEmpty
                                ?
                            Icon(
                          Icons.shopping_basket,

                          key: ValueKey('iconWithoutBadge'),
                        )
                        : Badge.count(
                            textColor: AppColors.kWhiteColor,
                            backgroundColor: AppColors.primary,
                            count: cartController.cartItems.length,
                            key: ValueKey('iconWithBadge'),
                            child: Icon(
                              Icons.shopping_basket,
                              
                            ),
                          ),
                        );
                  }),
                  title: "Cart"),
            ),
            PersistentTabConfig(
              screen: Scaffold(),
              item: ItemConfig(
                activeForegroundColor: AppColors.primary,
                icon: Icon(Icons.shopping_bag),
                title: "Order",
              ),
            ),
            PersistentTabConfig(
              screen: Scaffold(),
              item: ItemConfig(
                activeForegroundColor: AppColors.primary,
                icon: Icon(Icons.person),
                title: "Profile",
              ),
            ),
          ],
          navBarBuilder: (navBarConfig) => Style1BottomNavBar(
            navBarConfig: navBarConfig,
          ),
          controller: controller.persistentTabController,
          backgroundColor: AppColors.scaffoldBackgroundLight,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
        );
      },
    );
  }
}
