// import 'package:ezy_shop/app/components/quantity_button.dart';
// import 'package:ezy_shop/app/models/product_response.dart';
// import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';

// import '../components/text_component.dart';

// class ProductGrid extends StatelessWidget {
//   const ProductGrid({super.key, required this.item});
//   final Products? item;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // pushWithNavBar(
//         //     context,
//         //     MaterialPageRoute(
//         //         builder: (context) => ProductDetailsScreen(item: item)));
     
//       },
//       child: GFCard(
//         padding: EdgeInsets.all(10),
//         image: Image.network(item!.prouductImages!.first.image!),
//  title: GFListTile(
//    avatar: GFAvatar(
//     // backgroundImage: AssetImage('your asset image'),
//    ),
//    title:  TextComponent(
//               item!.title,
            
//               textAlign: TextAlign.start,
//             ),
//    subTitle: TextComponent(
//               item!.sku,
          
//               textAlign: TextAlign.start,
//             ),
// ),
//         // content: Column(
//         //   mainAxisSize: MainAxisSize.min,
//         //   crossAxisAlignment: CrossAxisAlignment.stretch,
//         //   children: [
         
//         //     TextComponent(
//         //       item!.title,
      
//         //       textAlign: TextAlign.start,
//         //     ),
//         //     TextComponent(
//         //       item!.sku,
            
//         //       textAlign: TextAlign.start,
//         //     ),
//         //     // TextComponent(
//         //     //   "${CurrencySign.appCurrency} ${item!.price}",
//         //     //   textType: TextType.priceText,
//         //     //   textAlign: TextAlign.start,
//         //     // ),
//         //     // Row(
//         //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //     //   children: [
//         //     //     // Padding(
//         //     //     //   padding: const EdgeInsets.only(right: 5),
//         //     //     //   child: getDiscount(
//         //     //     //       discountPercent: '10%',
//         //     //     //       textType: TextType.activeButtonText,
//         //     //     //       backgroundColor: AppColors.yellow),
//         //     //     // ),
//         //     //     Flexible(child: QuantityButton(item: item)),
//         //     //   ],
//         //     // ),
//         //   ],
//         // ),
     
     
//       ),
//     );
//   }
// }




