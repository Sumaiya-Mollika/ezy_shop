import 'package:ezy_shop/app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../services/auth_services.dart';
import '../utils/constants.dart';
import '../views/dashboard/dashboard_screen.dart';

class AuthController extends GetxController {
  late final AuthServices _authService;
  @override
  void onInit() {
    _authService = AuthServices();

    super.onInit();
  }

  var isLoading = RxBool(false);
  final userName = RxString("");
  final password = RxString("");
  final storage = GetStorage();

  void signInUser(BuildContext context) async {
    if (userName.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Username and password cannot be empty',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.kErrorColor.withValues(alpha: 0.5));
      return;
    }

    isLoading.value = true;

    try {
      final response = await _authService.signIn({
        'identifier': userName.value,
        'password': password.value,
      });

      if (response.data != null) {
        storage.write(StorageKey.token, response.data!.token);
        storage.write(StorageKey.user, response.data!.toJson());

        pushScreen(
          context,
          screen: DashboardScreen(),
          withNavBar: true,
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
