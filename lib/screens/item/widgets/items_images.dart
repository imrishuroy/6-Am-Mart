import 'package:flutter/material.dart';
import '/config/urls.dart';
import '/widgets/display_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemImages extends StatefulWidget {
  final List<String?> images;
  const ItemImages({Key? key, required this.images}) : super(key: key);

  @override
  State<ItemImages> createState() => _ItemImagesState();
}

class _ItemImagesState extends State<ItemImages> {
  int activeTabIndex = 0;

  int carouselActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250.0,
          //  width: 250.0,
          width: double.infinity,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                carouselActiveIndex = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              final itemImg = '${Urls.itemImage}${widget.images[index]}';

              print('lalkaka $itemImg');
              return DisplayImage(
                imageUrl: itemImg,
                fit: BoxFit.cover,
                height: 250.0,
                width: 250.0,
              );
            },
          ),
        ),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: carouselActiveIndex,
            count: widget.images.length,
            effect: ScrollingDotsEffect(
              activeDotColor: Colors.green,
              activeStrokeWidth: 9.0,
              dotHeight: 6.0,
              dotWidth: 6.0,
              dotColor: Colors.green.shade200,
            ),
          ),
        ),
      ],
    );
  }
}
