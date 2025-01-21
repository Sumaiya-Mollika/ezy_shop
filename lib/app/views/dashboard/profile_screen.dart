import 'package:ezy_shop/app/components/text_component.dart';
import 'package:ezy_shop/app/controllers/auth_controller.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:ezy_shop/app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    authController.getUser();
    return Scaffold(
      appBar: GFAppBar(centerTitle: true, title: Text("Profile")),
      body: Column(
        children: [
          GFListTile(
            color: AppColors.primary.withValues(alpha: 0.2),
            avatar: GFAvatar(),
            title: Text(authController.user.value!.username!),
            subTitle: Text(authController.user.value!.phone!),
          ),
          GFListTile(
              onTap: () async {
                await storage.remove(StorageKey.token);
                Get.offAll(() => LoginScreen(),
                    transition: Transition.rightToLeft);
              },
              color: AppColors.primary.withValues(alpha: 0.2),
              title: TextComponent("Logout"),
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.logout),
              )),
        ],
      ),
    );
  }
}
