import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:six_am_mart/helpers/dimensions.dart';
import 'package:six_am_mart/models/banner.dart';

class BannerView extends StatelessWidget {
  final List<AppBanner?> banners;
  const BannerView({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Expanded(
      child: CarouselSlider.builder(
        options: CarouselOptions(
            height: size.height * 0.18,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            onPageChanged: (index, reason) {
              // setState(() {
              //   topCarouselActiveIndex = index;
              // });
            }),
        itemCount: banners.length,
        itemBuilder: (context, index, realIndex) {
          final banner = banners[index];

          final imageUrl =
              'https://6ammart-admin.6amtech.com/storage/app/public/banner/' +
                  '${banner?.image}';
          //final imgUrl = carouselImageUrls[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
