import 'package:ezy_shop/app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../gen/assets.gen.dart';
import '../utils/constants.dart';
import 'dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    startTime();
  }

  Future<void> startTime() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;

    try {
      var token = await storage.read(StorageKey.token);

      if (token != null) {
        pushScreen(
          context,
          screen: DashboardScreen(),
          withNavBar: true,
        );
      } else {
        Get.offAll(() => LoginScreen(), transition: Transition.rightToLeft);
      }
    } catch (e) {
      if (mounted) {
        Get.offAll(() => LoginScreen(), transition: Transition.rightToLeft);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.images.groceryBag.path,
        ),
      ),
    );
  }
}
