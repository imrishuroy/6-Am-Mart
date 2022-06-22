import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:six_am_mart/utils/utils.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;

  const CustomImage({
    Key? key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Image.asset(Images.placeholder,
          height: height, width: width, fit: fit),
      errorWidget: (context, url, error) => Image.asset(
        Images.placeholder,
        height: height,
        width: width,
        fit: fit,
      ),
    );
  }
}
