import 'package:ezy_shop/app/components/text_component.dart';
import 'package:ezy_shop/app/models/product_response.dart';
import 'package:ezy_shop/app/utils/constants.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../models/cart_item.dart';



  Widget getPromotion(
    Promotion? promotion
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        TextComponent(
                "Promotion",
                textAlign: TextAlign.start,
                color: AppColors.kErrorColor,
                fontWeight: AppFontWeight.titleFontWeight,
              ),
         
            TextComponent(
            promotion!.description,
              textAlign: TextAlign.start,
              color: AppColors.kErrorColor,
               fontSize: TextSize.k14FontSize,
            ),
      ],
    );
  }


void showImageDialog(BuildContext context, String title, String imageUrl) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  Get.dialog(
     _AnimatedDialog(
      title: title,
      imageUrl: imageUrl,
      width: screenWidth,
      height: screenHeight * 0.6,
    ),
  );
}

class _AnimatedDialog extends StatefulWidget {
  final String title;
  final String imageUrl;
  final double width;
  final double height;

  const _AnimatedDialog({
    required this.title,
    required this.imageUrl,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<_AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut
    );
    _controller.forward();
  }

  Future<void> _closeDialog() async {
    await _controller.reverse();
   Get.back();
    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 100,horizontal: 20),
               color: AppColors.kWhiteColor ,
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          
            spacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: (){
                  _closeDialog();
                    },
                    child: Icon(Icons.cancel_rounded)),
                ),
              ),
                TextComponent(widget.title,color: AppColors.primary,fontSize: TextSize.titleFontSize,),
              Container(
                color: AppColors.kWhiteColor,
            
                height: widget.height*.6,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: PhotoView(
                  backgroundDecoration: const BoxDecoration(
                    color: AppColors.kWhiteColor,
                  ),
                  imageProvider: NetworkImage(widget.imageUrl),
                ),
              ),
            ],
          ),
        ),
     // ),
    );
  }
}


  String? getPromotionText(CartItem cartItem) {
    if (cartItem.product.promotion == null) {
      return null;
    }

    final promotion = cartItem.product.promotion!;
    if (promotion.type == PromotionType.weight) {
      return _applyWeightPromotion(cartItem);
    } else if (promotion.type == PromotionType.gwp) {
      return _applyGWPPromotion(cartItem);
    }

    return null; 
  }

  String _applyWeightPromotion(CartItem cartItem) {
    final promotionDetails = cartItem.product.promotion!.promotionDetails!;
    final totalWeight = cartItem.quantity * cartItem.product.weight!;
    final regularPrice = cartItem.quantity * cartItem.product.mrp!;
    for (var detail in promotionDetails) {
      if (detail.minWeight! <= totalWeight &&
          (detail.maxWeight == null || totalWeight <= detail.maxWeight!)) {
        final discount = detail.amount!;

        final discountPrice = (totalWeight / 1000) * discount;
        final discountedPrice = regularPrice - discountPrice;
        return '৳${discountedPrice.toStringAsFixed(2)} (৳$discount off/kg)';
      }
    }

    return '৳${cartItem.product.mrp! * cartItem.quantity}';
  }

  String? _applyGWPPromotion(CartItem cartItem) {
   //  final cartController = Get.put(CartController());
 
    final promotionDetails = cartItem.product.promotion!.promotionDetails!;
    final totalWeight = cartItem.quantity * cartItem.product.weight!;

    for (var detail in promotionDetails) {
      if (totalWeight >= detail.ruleWeight!) {
        int numberOfGift = (totalWeight / detail.ruleWeight!).floor();
        final numberOfFreeProduct = numberOfGift * detail.amount!.toInt();
//         if(numberOfFreeProduct!=0){
// cartController.addToCart(Products(
//   id: detail.discountProduct!.id,
//   title: detail.discountProduct!.title,
//   prouductImages: detail.discountProduct!.productImages
// ), numberOfFreeProduct);
//         }

        return '৳${cartItem.product.mrp! * cartItem.quantity} + $numberOfFreeProduct ${detail.discountProduct!.title}';
      }
    }
return null;

  }