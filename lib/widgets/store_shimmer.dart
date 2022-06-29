import 'package:flutter/material.dart';
import '/helpers/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '/widgets/ratting_bar.dart';

class StoreShimmer extends StatelessWidget {
  final bool isEnable;

  const StoreShimmer({super.key, required this.isEnable});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1, blurRadius: 5,
            //    Colors.grey[Get.isDarkMode ? 800 : 300], spreadRadius: 1, blurRadius: 5,
          )
        ],
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        enabled: isEnable,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: size.width * 0.3,
            width: Dimensions.webMaxWidth,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(Dimensions.radiusSmall)),
              color: Colors.grey[300],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: Row(children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 15, width: 150, color: Colors.grey[300]),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Container(height: 10, width: 50, color: Colors.grey[300]),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      const RatingBar(rating: 0, size: 12, ratingCount: 0),
                    ]),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Icon(Icons.favorite_border,
                  size: 25, color: Theme.of(context).disabledColor),
            ]),
          )),
        ]),
      ),
    );
  }
}
