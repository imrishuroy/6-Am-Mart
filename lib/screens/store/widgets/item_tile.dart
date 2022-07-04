import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:six_am_mart/blocs/cart/cart_cubit.dart';
import 'package:six_am_mart/blocs/item/item_cubit.dart';
import 'package:six_am_mart/models/cart_model.dart';
import 'package:six_am_mart/translations/locale_keys.g.dart';
import 'package:six_am_mart/widgets/show_snakbar.dart';
import '/constants/colors_const.dart';
import '/screens/item/item_details_screen.dart';
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
    print('Item  we are showing  -- $item');
    final imgUrl = '${Urls.itemImage}${item?.image}';

    double? price = (item?.price != null &&
            item?.discount != null &&
            item?.discount != 0.0 &&
            item?.discountType == 'percent')
        ? item!.price! - (item!.price! * item!.discount! / 100)
        : null;

    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: SizedBox(
        // width: 175.0,
        child: Stack(
          fit: StackFit.loose,
          children: [
            SizedBox(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 7.0),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (item?.discount != 0.0)
                                    Text(
                                      '₹${item?.price ?? 'N/A'}',
                                      // '₹${item?.price ?? 0.0)} * (item?.discount ?? 1)}',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.w500,
                                        fontSize: 13.0,
                                        color: Colors.grey.shade600,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  Text(
                                    '₹${price ?? item?.price ?? 'N/A'}',
                                    // '₹${item?.price ?? 0.0)} * (item?.discount ?? 1)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print('Price -- ${item?.price}');
                                print('DIscount -- ${item?.discount}');

                                final CartModel cartModel = CartModel(
                                  price: item?.price,
                                  discountedPrice: (item?.price ?? 0) -
                                      (item?.discount ?? 0),
                                  variation: const [],
                                  addOnIds: const [],
                                  addOns: const [],
                                  item: item,
                                  quantity: 1,
                                );

                                context.read<CartCubit>().addToCart(cartModel,
                                    context.read<ItemCubit>().state.cartIndex);

                                ShowSnackBar.showSnackBar(
                                  context,
                                  backgroundColor: Colors.green,
                                  title: LocaleKeys.item_added_to_cart.tr(),
                                );
                              },
                              child: Container(
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
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Icon(Icons.star),
            // )
            if (item?.discount != null && item?.discount != 0.0)
              Positioned(
                //alignment: Alignment.topRight,
                top: 0.0,
                right: 0.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/hexagon.svg',
                      color: green,
                      height: 40.0,
                      width: 40.0,
                    ),

                    Text(
                      '${item?.discount?.toInt()}%\nOff',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // ),
                  ],
                ),

                // Container(
                //   // alignment: Alignment.topRight,
                //   padding: const EdgeInsets.all(3.2),
                //   decoration: const BoxDecoration(
                //     color: green,
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(8.0),
                //       bottomLeft: Radius.circular(8.0),
                //     ),
                //   ),
                //   child: Text(
                //     '${item?.discount}% OFF',
                //     style: const TextStyle(
                //       color: Colors.white,
                //       fontSize: 10.0,
                //     ),
                //   ),
                // ),
              )
          ],
        ),
      ),
    );
  }
}
