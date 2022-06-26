import 'package:flutter/material.dart';
import 'package:six_am_mart/widgets/display_image.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, required this.imageSrc}) : super(key: key);
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    // log(AppConstants.BASE_URL + '/' + imageSrc);
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: DisplayImage(
          imageUrl: imageSrc,
        ),

        // Image.network(
        //   imageSrc,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
