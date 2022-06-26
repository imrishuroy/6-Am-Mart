import 'package:flutter/material.dart';
import '/widgets/display_image.dart';

class ModuleTile extends StatelessWidget {
  const ModuleTile({Key? key, required this.imageSrc}) : super(key: key);
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    // log(AppConstants.BASE_URL + '/' + imageSrc);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DisplayImage(
        imageUrl: imageSrc,
        fit: BoxFit.contain,
      ),
    );

    // return Container(
    //   height: 140,
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(8),
    //     border: Border.all(
    //       color: Colors.grey.shade400,
    //     ),
    //   ),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(8),
    //     child: DisplayImage(
    //       imageUrl: imageSrc,
    //     ),

    //     // Image.network(
    //     //   imageSrc,
    //     //   fit: BoxFit.cover,
    //     // ),
    //   ),
    // );
  }
}
