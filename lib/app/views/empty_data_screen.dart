import 'package:ezy_shop/app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../components/text_component.dart';

class EmptyDataScreen extends StatelessWidget {
  const EmptyDataScreen(
      {super.key, this.title, this.buttonText, this.imageUrl, this.onTap});
  final String? title;
  final String? buttonText;
  final String? imageUrl;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GFAvatar(
              backgroundColor: Colors.transparent,
              shape: GFAvatarShape.standard,
              backgroundImage: AssetImage(imageUrl!),
            ),
            TextComponent(
              title,
            ),
            GFButton(
              color: AppColors.primary,
              onPressed: onTap,
              child: TextComponent(
                buttonText,
                color: AppColors.kWhiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
