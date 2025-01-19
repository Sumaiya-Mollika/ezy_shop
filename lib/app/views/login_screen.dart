import 'package:ezy_shop/app/components/text_component.dart';
import 'package:ezy_shop/app/components/text_field_component.dart';
import 'package:ezy_shop/app/controllers/auth_controller.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:ezy_shop/app/views/dashboard/dashboard_screen.dart';
import 'package:ezy_shop/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class LoginScreen extends StatelessWidget {
  final authController = Get.put(AuthController());
  // final TextEditingController identifierController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.background.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Login form
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextComponent(
                    'Login',
                    fontWeight: AppFontWeight.titleFontWeight,
                    fontSize: TextSize.titleFontSize,
                    color: AppColors.kWhiteColor,
                  ),
                  TextFieldComponent(
                    onChanged: (String? identifier) {
                      authController.userName.value=identifier!
                      ;
                    },


                    hint: 'UserName',
                  ),
                  TextFieldComponent(
                    onChanged: (String? password) {
                      authController.password.value=password!;
                    },
                    hint: 'Password',
                    isPasswordField: true,
                  ),
                  Obx(() {
                    return authController.isLoading.value
                        ?  GFLoader()
                        : GFButton(
                            onPressed: () {
                              authController.signInUser(context);
                
                            },
                            text: "Login",
                           color: AppColors.primary,
                          );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
