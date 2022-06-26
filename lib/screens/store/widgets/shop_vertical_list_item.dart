
// import 'package:flutter/material.dart';

// class ShopListVerticalItem extends StatelessWidget {
//   final String? name;
//   final String logo;
//   final String? description;
//   final String? openHour;
//   final String? closeHour;
//   final String? rating;
//   final bool isLast;

//   const ShopListVerticalItem({
//     super.key,
//     required this.name,
//     required this.logo,
//     required this.description,
//     required this.openHour,
//     required this.closeHour,
//     required this.rating,
//     this.isLast = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 24),
//       margin: EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//           border: isLast
//               ? null
//               : Border(
//                   bottom: BorderSide(
//                       width: 1, color: Color.fromRGBO(136, 136, 126, 0.2)))),
//       child: Row(
//         children: <Widget>[
//           Container(
//             width: 80,
//             height: 80,
//             margin: EdgeInsets.only(left: 6, right: 14),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(40),
//               child: Image.network(
//                 logo,
//                 fit: BoxFit.fitWidth,
//                 width: 80,
//                 height: 80,
//               ),
//             ),
//           ),
//           Container(
//             // width: 1.sw - 130,
//             height: 80,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "$name",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14,
//                       letterSpacing: -0.4,
//                       color: Color.fromRGBO(0, 0, 0, 1)),
//                 ),
//                 Text(
//                   "$description",
//                   maxLines: 2,
//                   overflow: TextOverflow.clip,
//                   style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 12,
//                       letterSpacing: -0.4,
//                       color: Color.fromRGBO(136, 136, 126, 1)),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top: 10),
//                   alignment: Alignment.center,
//                   child: Row(
//                     children: <Widget>[
//                       Text(
//                         "$openHour — $closeHour",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 12,
//                           letterSpacing: -0.4,
//                           color: Color.fromRGBO(0, 0, 0, 1),
//                         ),

//                         // Get.isDarkMode
//                         //     ? Color.fromRGBO(255, 255, 255, 1)
//                         //     : ),
//                       ),
//                       // Container(
//                       //   width: 40,
//                       //   margin: EdgeInsets.only(left: 15),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       //     children: <Widget>[
//                       //       Icon(
//                       //         const IconData(0xf18e, fontFamily: 'MIcon'),
//                       //         size: 16.sp,
//                       //         color: Color.fromRGBO(255, 161, 0, 1),
//                       //       ),
//                       //       Text(
//                       //         "$rating",
//                       //         style: TextStyle(
//                       //             fontFamily: 'Inter',
//                       //             fontWeight: FontWeight.w500,
//                       //             fontSize: 12.sp,
//                       //             letterSpacing: -0.4,
//                       //             color: Get.isDarkMode
//                       //                 ? Color.fromRGBO(255, 255, 255, 1)
//                       //                 : Color.fromRGBO(0, 0, 0, 1)),
//                       //       )
//                       //     ],
//                       //   ),
//                       // )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
