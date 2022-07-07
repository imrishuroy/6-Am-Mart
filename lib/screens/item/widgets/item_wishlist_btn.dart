import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:six_am_mart/blocs/wishlist/wishlist_cubit.dart';
import 'package:six_am_mart/models/item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemWislistBtn extends StatelessWidget {
  final Item? item;

  const ItemWislistBtn({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final wishListState = context.watch<WishlistCubit>().state;
    final isWishListed = wishListState.wishItemList.contains(item);

    print('Is wishlisted --- $isWishListed');

    print('Wnanannaana -- ${wishListState.wishItemList}');
    print('Wnanannaana --1 $item');
    print('Wnanannaana -- 3 ${wishListState.wishItemList[0]}');

    print('Wnanannaana  2--- ${item == wishListState.wishItemList[0]}');

    return IconButton(
      onPressed: () {
        if (isWishListed) {
          // remove the item from wishlist

        } else {
          // add the item
          context.read<WishlistCubit>().addToWishList(item, null, false);
        }
      },
      icon: isWishListed
          ? const Icon(Icons.favorite, color: Colors.red)
          : const Icon(Icons.favorite_border),
    );
  }
}
