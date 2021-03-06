import 'package:flutter/material.dart';
import '/screens/store/screens/store_items_screen.dart';
import '/config/urls.dart';
import '/models/store.dart';
import '/widgets/display_image.dart';
import '/widgets/ratting_bar.dart';

class AllStores extends StatelessWidget {
  final List<Store?> allStores;
  const AllStores({Key? key, required this.allStores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allStores.length,
      itemBuilder: (context, index) {
        final store = allStores[index];
        final imgUrl = '${Urls.storeCoverImg}${store?.coverPhoto}';
        return Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
              StoresItemsScreen.routeName,
              arguments: StoresItemsArgs(store: store),
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: DisplayImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(width: 12.0),
                SizedBox(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: size.width * 0.6,
                        child: Text(
                          store?.name ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            letterSpacing: -0.4,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.6,
                        child: Text(
                          store?.address ?? 'N/A',
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              letterSpacing: -0.4,
                              color: Color.fromRGBO(136, 136, 126, 1)),
                        ),
                      ),
                      RatingBar(
                        rating: store?.avgRating?.toDouble() ?? 0,
                        ratingCount: store?.avgRating?.toInt() ?? 0,
                        size: 14.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
