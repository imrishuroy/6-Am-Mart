import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:flutter/material.dart';
import '/blocs/auth/auth_bloc.dart';
import '/blocs/config/app_config_bloc.dart';
import '/blocs/wishlist/wishlist_cubit.dart';
import '/helpers/dimensions.dart';
import '/models/config-model/base_urls.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';
import '/widgets/show_snakbar.dart';
import '/helpers/responsive_helper.dart';
import '/models/store.dart';
import 'custom_image.dart';

import 'ratting_bar.dart';

class StoreWidget extends StatelessWidget {
  final Store? store;
  final int index;
  final bool inStore;

  const StoreWidget(
      {Key? key,
      required this.store,
      required this.index,
      this.inStore = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<AppConfigBloc>();
    final size = MediaQuery.of(context).size;

    BaseUrls? baseUrls = configBloc.state.configModel?.baseUrls;
    bool desktop = ResponsiveHelper.isDesktop(context);
    return InkWell(
      onTap: () {
        // Get.toNamed(
        //   RouteHelper.getStoreRoute(store.id, 'item'),
        //   arguments: StoreScreen(store: store, fromModule: false),
        // );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              //  color: Colors.grey[Get.isDarkMode ? 800 : 300],
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(Dimensions.radiusSmall),
                ),
                child: CustomImage(
                  image: '${baseUrls?.storeCoverPhotoUrl}/${store?.coverPhoto}',
                  height: size.width * 0.3,
                  width: Dimensions.webMaxWidth,
                  fit: BoxFit.cover,
                )),

            /// TODO: implement store controller
            // DiscountTag(
            //   discount: Get.find<StoreController>().getDiscount(store),
            //   discountType: Get.find<StoreController>().getDiscountType(store),
            //   freeDelivery: store.freeDelivery,
            // ),
            // Get.find<StoreController>().isOpenNow(store)
            //     ? SizedBox()
            //     : NotAvailableWidget(isStore: true),
          ]),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: Row(children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        store?.name ?? 'N/A',
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeSmall),
                        maxLines: desktop ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      (store?.address != null)
                          ? Text(
                              store?.address ?? '',
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeExtraSmall,
                                color: Theme.of(context).disabledColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : const SizedBox.shrink(),
                      SizedBox(height: store?.address != null ? 2 : 0),
                      RatingBar(
                        rating: store?.avgRating?.toDouble() ?? 0.0,
                        size: desktop ? 15 : 12,
                        ratingCount: store?.ratingCount,
                      ),
                    ]),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              BlocBuilder<WishlistCubit, WishListState>(
                  builder: ((context, state) {
                bool isWished = state.wishStoreIdList.contains(store?.id);
                return InkWell(
                  onTap: () {
                    if (store != null) {
                      if (context.read<AuthBloc>().state.isLoggedIn()) {
                        isWished
                            ? context
                                .read<WishlistCubit>()
                                .removeFromWishList(store!.id!, true)
                            : context
                                .read<WishlistCubit>()
                                .addToWishList(null, store!, true);
                      } else {
                        ShowSnackBar.showSnackBar(context,
                            title: LocaleKeys.you_are_not_logged_in.tr());
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: desktop ? Dimensions.paddingSizeSmall : 0),
                    child: Icon(
                      isWished ? Icons.favorite : Icons.favorite_border,
                      size: desktop ? 30 : 25,
                      color: isWished
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                );
              })),
            ]),
          )),
        ]),
      ),
    );
  }
}

class StoreShimmer extends StatelessWidget {
  final bool isEnable;
  const StoreShimmer({Key? key, required this.isEnable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            // color: Colors.grey[Get.isDarkMode ? 800 : 300],
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        enabled: isEnable,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: size.width * 0.3,
            width: Dimensions.webMaxWidth,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(Dimensions.radiusSmall)),
              color: Colors.grey[300],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: Row(children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 15, width: 150, color: Colors.grey[300]),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Container(height: 10, width: 50, color: Colors.grey[300]),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      const RatingBar(rating: 0, size: 12, ratingCount: 0),
                    ]),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Icon(Icons.favorite_border,
                  size: 25, color: Theme.of(context).disabledColor),
            ]),
          )),
        ]),
      ),
    );
  }
}
