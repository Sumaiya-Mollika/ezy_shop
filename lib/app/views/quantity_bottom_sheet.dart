import 'package:ezy_shop/app/components/text_component.dart';
import 'package:ezy_shop/app/models/cart_item.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:ezy_shop/app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezy_shop/app/controllers/cart_controller.dart';
import 'package:ezy_shop/app/models/product_response.dart';
import 'package:getwidget/getwidget.dart';

class QuantityBottomSheet extends StatelessWidget {
  final Products product;
  const QuantityBottomSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final RxInt quantity = (product.minimumOrderQuantity ?? 1).obs;
   // var promotionText = getPromotionText(CartItem(product: product, quantity: quantity.value));
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            product.title ?? 'Product',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Stock: ${product.stock}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Min Order Quantity: ${product.minimumOrderQuantity}',
            style: TextStyle(fontSize: 16),
          ),
          Obx(
         ()=> Text(
              'price: ${getPromotionText(CartItem(product: product, quantity: quantity.value)) ??
                          '৳${product.mrp! * quantity.value}'}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (quantity.value > product.minimumOrderQuantity!) {
                    quantity.value -= 1;
                  }
                },
                icon: Icon(Icons.remove),
              ),
              Obx(
                () => SizedBox(
                  width: 80,
                  child: TextField(
                    controller:
                        TextEditingController(text: quantity.value.toString()),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        quantity.value = product.minimumOrderQuantity!;
                      } else {
                        int newValue = int.tryParse(value) ??
                            product.minimumOrderQuantity!;
                        if (newValue > product.stock!) {
                          quantity.value = product.stock!;
                        } else if (newValue < product.minimumOrderQuantity!) {
                          quantity.value = product.minimumOrderQuantity!;
                        } else {
                          quantity.value = newValue;
                        }
                      }
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (quantity.value < product.stock!) {
                    quantity.value += 1;
                  }
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (product.promotion != null) getPromotion(product.promotion),
          GFButton(
            color: AppColors.primary,
            onPressed:quantity.value!=0? () {
              cartController.addToCart(product, quantity.value);
              Get.back();
            }:null,
            child: TextComponent(
              'Add to Cart',
              fontSize: TextSize.k14FontSize,
              color: AppColors.kWhiteColor,
            ),
          )
        ],
      ),
    );
  }
}
