import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/wishlist/wishlist_cubit.dart';
import '/translations/locale_keys.g.dart';
import '/widgets/item_view.dart';
import '/blocs/config/app_config_bloc.dart';
import '/helpers/dimensions.dart';
import '/widgets/footer_view.dart';

class FavItemView extends StatelessWidget {
  final bool isStore;
  final bool isSearch;

  const FavItemView({
    super.key,
    required this.isStore,
    this.isSearch = false,
  });

  //FavItemView({required this.isStore, this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<AppConfigBloc>();
    return Scaffold(
      body:

          //  GetBuilder<WishListController>(builder: (wishController) {
          //   return RefreshIndicator(
          //     onRefresh: () async {
          //       await wishController.getWishList();
          //     },
          //     child:

          BlocConsumer<WishlistCubit, WishListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: FooterView(
              child: SizedBox(
                width: Dimensions.webMaxWidth,
                child: ItemsView(
                  isStore: isStore,
                  items: state.wishItemList,
                  stores: state.wishStoreList,
                  noDataText: LocaleKeys.no_wish_data_found.tr(),
                ),
              ),
            ),
          );
        },
      ),
    );
    //}),
    //);
  }
}
