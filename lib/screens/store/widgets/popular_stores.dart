import 'package:flutter/material.dart';
import '/config/urls.dart';
import '/models/store.dart';
import '/widgets/display_image.dart';
import '/widgets/ratting_bar.dart';

class PopularStores extends StatelessWidget {
  final List<Store?> popularStores;
  const PopularStores({Key? key, required this.popularStores})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205.0,
      child: popularStores.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularStores.length,
              itemBuilder: (context, index) {
                final store = popularStores[index];
                final imgUrl = '${Urls.storeCoverImg}${store?.coverPhoto}';

                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0),
                        ),
                        child: DisplayImage(
                          imageUrl: imgUrl,
                          fit: BoxFit.cover,
                          width: 250.0,
                          // width: double.infinity,
                          height: 120.0,
                          // width: 100.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store?.name ?? 'N/A',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              store?.address ?? 'N/A',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.5,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            RatingBar(
                              rating: store?.avgRating?.toDouble() ?? 0,
                              ratingCount: store?.avgRating ?? 0,
                              size: 14.0,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
