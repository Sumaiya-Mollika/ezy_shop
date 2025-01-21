import 'package:ezy_shop/app/components/text_component.dart';
import 'package:ezy_shop/app/models/cart_item.dart';
import 'package:ezy_shop/app/utils/style.dart';
import 'package:ezy_shop/app/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezy_shop/app/controllers/cart_controller.dart';
import 'package:ezy_shop/app/models/product_response.dart';
import '../../components/app_button.dart';
import '../../utils/constants.dart';

class QuantityBottomSheet extends StatelessWidget {
  final Products product;
  const QuantityBottomSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final RxInt quantity = (cartController.getProductQuantity(product.id!) ??
            product.minimumOrderQuantity!)
        .obs;
    final TextEditingController quantityController =
        TextEditingController(text: quantity.value.toString());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          spacing: 6,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent(
                  product.title ?? 'Product',
                  fontWeight: AppFontWeight.titleFontWeight,
                  fontSize: TextSize.titleFontSize,
                ),
                GestureDetector(
                    onTap: () {
                      if (cartController.isProductInCart(product.id!)) {
                        cartController.updateCartProductQuantity(
                            product.id!, quantity.value);
                      }

                      Get.back();
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColors.kErrorColor,
                      size: 30,
                    )),
              ],
            ),
            TextComponent(
              'Stock: ${product.stock}',
            ),
            TextComponent(
              'Min Order Quantity: ${product.minimumOrderQuantity}',
            ),
            Obx(
              () => TextComponent(
                'price: ${getPromotionText(CartItem(product: product, quantity: quantity.value)) ?? '${CurrencySign.appCurrency}${product.mrp! * quantity.value}'}',
              ),
            ),
            Obx(
              () => cartController.isProductInCart(product.id!)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20,
                      children: [
                        TextComponent(
                          'Quantity:',
                        ),
                        SizedBox(
                          width: Get.width * .5,
                          child: TextFormField(
                            controller: quantityController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.zero,
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 40, minHeight: 40),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 40, minHeight: 40),
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  if (quantity.value >
                                      product.minimumOrderQuantity!) {
                                    quantity.value -= 1;
                                    quantityController.text =
                                        quantity.value.toString();
                                  }
                                  cartController.updateCartProductQuantity(
                                      product.id!, quantity.value);
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.kErrorColor,
                                  size: 30,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  if (quantity.value < product.stock!) {
                                    quantity.value += 1;
                                    quantityController.text =
                                        quantity.value.toString();
                                  }
                                  cartController.updateCartProductQuantity(
                                      product.id!, quantity.value);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                              ),
                            ),
                            validator: (value) {
                              int newValue = int.tryParse(value!) ??
                                  product.minimumOrderQuantity!;
                              if (newValue > product.stock!) {
                                return 'Maximum quantity is ${product.stock}';
                              } else if (newValue <
                                  product.minimumOrderQuantity!) {
                                return 'Minimum quantity is ${product.minimumOrderQuantity}';
                              }
                              return null;
                            },
                            onTapOutside: (event) {
                              if (formKey.currentState!.validate()) {
                                cartController.updateCartProductQuantity(
                                    product.id!, quantity.value);
                              }
                            },
                            onChanged: (value) {
                              if (formKey.currentState!.validate()) {
                                int newValue = int.tryParse(value) ??
                                    product.minimumOrderQuantity!;
                                quantity.value = newValue;
                                cartController.updateCartProductQuantity(
                                    product.id!, quantity.value);
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : Row(
                      spacing: 15,
                      children: [
                        TextComponent(
                          'Want to buy this product:',
                        ),
                        AppButton(
                          buttonText: "Add to Cart",
                          onButtonPress: quantity.value != 0
                              ? () {
                                  cartController.addToCart(
                                      product, quantity.value);
                                }
                              : null,
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 16),
            if (product.promotion != null) getPromotion(product.promotion),
          ],
        ),
      ),
    );
  }
}
