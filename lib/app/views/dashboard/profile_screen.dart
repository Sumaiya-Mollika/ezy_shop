import 'package:ezy_shop/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController=Get.put(AuthController());
authController.getUser();
    return  Scaffold(
      appBar: GFAppBar(
        title: Text('Your Cart')
      ),
    );
  }
}