import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/cart/cart_cubit.dart';
import '/blocs/item/item_cubit.dart';
import '/models/cart_model.dart';
import '/translations/locale_keys.g.dart';
import '/widgets/show_snakbar.dart';
import '/screens/item/widgets/choose_varient.dart';
import '/constants/constants.dart';
import '/widgets/ratting_bar.dart';
import '/models/item.dart';
import 'widgets/items_images.dart';

class ItemDetailsArgs {
  final Item? item;

  ItemDetailsArgs({required this.item});
}

class ItemDetailsScreen extends StatelessWidget {
  static const String routeName = '/itemDetails';
  final Item? item;

  const ItemDetailsScreen({Key? key, required this.item}) : super(key: key);

  static Route route({required ItemDetailsArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ItemDetailsScreen(item: args.item),
    );
  }

  void showVarient(BuildContext context) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          height: 600,
          child: ChooseVarient(item: item),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    const Text(
                      'Item Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30.0),
                ItemImages(
                  images: item?.images ?? [],
                ),
                const SizedBox(height: 50.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item?.name ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showVarient(context),
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
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.favorite_border,
                    //     color: Colors.grey,
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  '₹ ${item?.price.toString() ?? 'N/A'}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      item?.avgRating.toString() ?? '0.0',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    RatingBar(
                      rating: item?.avgRating ?? 0.0,
                      ratingCount: item?.ratingCount ?? 0,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Divider(thickness: 2.0),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 30.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.shade400,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.remove,
                              size: 18.0,
                            ),
                          ),
                          const Text('1'),
                          GestureDetector(
                            onTap: () {
                              print('Price -- ${item?.price}');
                              print('DIscount -- ${item?.discount}');

                              final CartModel cartModel = CartModel(
                                price: item?.price,
                                discountedPrice:
                                    (item?.price ?? 0) - (item?.discount ?? 0),
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
                            child: const Icon(
                              Icons.add,
                              size: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: 'Total Amount:'),
                      TextSpan(
                        text: ' ₹ ${item?.price.toString() ?? 'N/A'}',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  item?.description ?? 'N/A',
                  style: const TextStyle(fontSize: 14.5),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
