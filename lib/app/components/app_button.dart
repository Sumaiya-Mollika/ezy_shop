import 'package:ezy_shop/app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.buttonText,
    this.onButtonPress,
  });
  final String? buttonText;
  final VoidCallback? onButtonPress;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onButtonPress,
      text: buttonText,
      color: AppColors.primary,
    );
  }
}
