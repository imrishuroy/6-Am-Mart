import 'package:flutter/material.dart';
import 'package:six_am_mart/constants/colors_const.dart';
import 'package:six_am_mart/screens/item/item_details_screen.dart';
import '/config/urls.dart';
import '/models/item.dart';
import '/widgets/display_image.dart';

class ItemTile extends StatelessWidget {
  final Item? item;
  const ItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgUrl = '${Urls.itemImage}${item?.image}';
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: SizedBox(
        width: 168.0,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            ItemDetailsScreen.routeName,
            arguments: ItemDetailsArgs(item: item),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5.0),
                  Center(
                    child: DisplayImage(
                      imageUrl: imgUrl,
                      height: 120,
                      width: 120.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                    child: Text(
                      item?.name ?? 'N/A',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),

                  const SizedBox(height: 15.0),
                  Text(
                    '${item?.unit?.id} ${item?.unitType}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '₹${item?.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9.0,
                          vertical: 7.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 0.5),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                              color: green,
                              size: 20.0,
                            ),
                            SizedBox(width: 1.0),
                            Text(
                              'ADD',
                              style: TextStyle(
                                color: green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  //price
                  // + button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
