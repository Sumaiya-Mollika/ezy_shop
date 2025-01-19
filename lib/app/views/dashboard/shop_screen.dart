import 'package:ezy_shop/app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: GFAppBar(


  title: Text("Products"),
  actions: <Widget>[
    GFIconButton(
      color: AppColors.primary,
      icon: Icon(
        Icons.notifications,
        color: Colors.white,
      ),
      onPressed: () {},
      type: GFButtonType.transparent,
    ),
  ],
),
    );
  }
}