import 'package:ezy_shop/app/models/user.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final user = Rx<User?>(null);
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
        storage.write(StorageKey.user, response.data!.user!.toJson());

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

  getUser() {
    var userData = storage.read(StorageKey.user);
    if (userData != null) {
      user.value = User.fromJson(userData);
    } else {
      user.value = null;
    }
  }
}
