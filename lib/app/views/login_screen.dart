import 'package:ezy_shop/app/components/app_button.dart';
import 'package:ezy_shop/app/components/text_component.dart';
import 'package:ezy_shop/app/components/text_field_component.dart';
import 'package:ezy_shop/app/controllers/auth_controller.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:ezy_shop/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class LoginScreen extends StatelessWidget {
  final authController = Get.put(AuthController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.background.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                      authController.userName.value = identifier!;
                    },
                    hint: 'UserName',
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                  TextFieldComponent(
                    onChanged: (String? password) {
                      authController.password.value = password!;
                    },
                    hint: 'Password',
                    isPasswordField: true,
                  ),
                  Obx(() {
                    return authController.isLoading.value
                        ? GFLoader()
                        : AppButton(
                            buttonText: "Login",
                            onButtonPress:authController.userName.isNotEmpty&&authController.password.isNotEmpty? () {
                              authController.signInUser(context);
                            }:null,
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

