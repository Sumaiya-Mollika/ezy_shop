// import 'package:ezy_shop/app/models/product_response.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/cart_controller.dart';

// import '../utils/style.dart';
// import 'text_component.dart';

// class QuantityButton extends StatelessWidget {
//   final Products? item;
//   QuantityButton({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     final cartC = Get.put(CartController());
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Obx(() {
//           return ClipRect(
//             child: AnimatedContainer(
//               padding: EdgeInsets.symmetric(horizontal: 6),
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               height: 40,
//               width: item!.quantity.value == 0 ? 40 : 140.0,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: item!.quantity.value == 0
//                     ? Colors.transparent
//                     : Colors.grey[200],
//               ),
//               child: item!.quantity.value == 0
//                   ? GestureDetector(
//                       onTap: () {
//                         // cartC.addItemToCart(item!);
//                       },
//                       child: SizedBox(
//                         width: 40,
//                         child: Icon(
//                           Icons.add_box,
//                           color: AppColors.primary,
//                           size: 35,
//                         ),
//                       ),
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Flexible(
//                           child: GestureDetector(
//                             onTap: () {
//                               //   cartC.decrementItemQuantity(item!);
//                             },
//                             child: Icon(Icons.remove, color: Colors.red),
//                           ),
//                         ),
//                         Flexible(
//                           child: TextComponent(
//                             '${item!.quantity.value}',
//                           ),
//                         ),
//                         Flexible(
//                           child: GestureDetector(
//                             onTap: () {
//                               // cartC.incrementItemQuantity(item!);
//                             },
//                             child: Icon(Icons.add, color: Colors.green),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           );
//         });
//       },
//     );
//   }
// }
