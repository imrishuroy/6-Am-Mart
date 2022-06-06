// import 'package:flutter/material.dart';

// import 'shop_vertical_list_item.dart';

// class ShopListVertical extends StatelessWidget {
//   var shops = [
//     {
//       "name": "Zara",
//       "description": 'jsdnnjqwniqwq',
//       'logo_url':
//           "https://hips.hearstapps.com/hmg-prod/images/gettyimages-979027870-1548953531.jpg",
//       "openHour": '10:30',
//       "closeHour": '9:30',
//       'rating': '4.2'
//     },
//     {
//       "name": "Reliance Mart",
//       "description": 'jsdnnjqwniqwq',
//       'logo_url':
//           "https://content3.jdmagicbox.com/comp/mumbai/b9/022pxx22.xx22.180413091306.x1b9/catalogue/reliance-smart-kanchpada-malad-west-mumbai-supermarkets-8wi6l-250.jpg",
//       "openHour": '10:30',
//       "closeHour": '9:30',
//       'rating': '4.2'
//     },
//     {
//       "name": "Apollo Pharmacy",
//       "description": 'jsdnnjqwniqwq',
//       'logo_url':
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8tFFIlAYdbY_hl3k9KlQf20RcqIE13K8uqgNk43qWgtk7fdawZnOQ8TVP22NpbXyY75k&usqp=CAU",
//       "openHour": '10:30',
//       "closeHour": '11:30',
//       'rating': '4.2'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: EdgeInsets.only(top: 30, bottom: 30),
//         child: Column(children: <Widget>[
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   "All shops",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20,
//                     letterSpacing: -1,
//                     color: Color.fromRGBO(0, 0, 0, 1),
//                     // Get.isDarkMode
//                     //     ? Color.fromRGBO(255, 255, 255, 1)
//                     //     :
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // ShopCategoriesLisWidget(),
//           Container(
//               // width: 1.sw,
//               margin: EdgeInsets.only(bottom: 90),
//               child: Column(
//                   children: shops.map((shop) {
//                 int index = shops.indexWhere((element) => element == shop);
//                 return InkWell(
//                   child: ShopListVerticalItem(
//                     name: shop['name'],
//                     description: shop['description'],
//                     rating: shop['rating'],
//                     openHour: shop['openHour'],
//                     closeHour: shop['closeHour'],
//                     logo: shop['logo_url'] ?? '',
//                     isLast: index == (shops.length - 1),
//                   ),
//                   onTap: () {},
//                   // onTap: () => Get.to(() => StoreHome()),
//                 );
//               }).toList()))
//         ]));
//   }
// }
