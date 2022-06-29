import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/auth/auth_bloc.dart';
import '/blocs/wishlist/wishlist_cubit.dart';
import '/helpers/dimensions.dart';
import '/utils/date_converter.dart';
import '/utils/price_converter.dart';
import '/utils/utils.dart';
import '/widgets/show_snakbar.dart';
import '/blocs/config/app_config_bloc.dart';
import '/helpers/responsive_helper.dart';
import '/models/config-model/base_urls.dart';
import '/models/item.dart';
import '/models/store.dart';
import 'custom_image.dart';
import 'discount_tag.dart';
import 'not_available_widget.dart';
import 'ratting_bar.dart';

class ItemWidget extends StatelessWidget {
  final Item? item;
  final Store? store;
  final bool isStore;
  final int index;
  final int length;
  final bool inStore;
  final bool isCampaign;
  final bool isFeatured;

  const ItemWidget({
    Key? key,
    required this.item,
    required this.isStore,
    required this.store,
    required this.index,
    required this.length,
    this.inStore = false,
    this.isCampaign = false,
    this.isFeatured = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = context.read<AppConfigBloc>();
    BaseUrls? baseUrls = config.state.config?.baseUrls;

    bool desktop = ResponsiveHelper.isDesktop(context);
    double? discount;
    String? discountType;
    bool? isAvailable;
    if (isStore) {
      discount = store?.discount != null ? store?.discount?.discount : 0;
      discountType =
          store?.discount != null ? store?.discount?.discountType : 'percent';
      // bool _isClosedToday = Get.find<StoreController>().isRestaurantClosed(true, store.active, store.offDay);
      // _isAvailable = DateConverter.isAvailable(store.openingTime, store.closeingTime) && store.active && !_isClosedToday;
      // TODO check this
      // _isAvailable = store.open == 1 && store.active;
      isAvailable = store?.open == 1 && store?.active == true;
    } else {
      discount = (item?.storeDiscount == 0 || isCampaign)
          ? item?.discount
          : item?.storeDiscount;
      discountType = (item?.storeDiscount == 0 || isCampaign)
          ? item?.discountType
          : 'percent';
      isAvailable =
          item?.availableTimeStarts != null && item?.availableTimeEnds != null
              ? DateConverter.isAvailable(
                  context, item!.availableTimeStarts!, item!.availableTimeEnds!)
              : false;
      // DateConverter.isAvailable(
      //     context: context, item.availableTimeStarts, item.availableTimeEnds);
    }

    return InkWell(
      onTap: () {
        if (isStore) {
          // Get.toNamed(
          //   RouteHelper.getStoreRoute(store.id, isFeatured ? 'module' : 'item'),
          //   arguments: StoreScreen(store: store, fromModule: isFeatured),
          // );
        } else {
          // Get.find<ItemController>().navigateToItemPage(item, context,
          //     inStore: inStore, isCampaign: isCampaign);
        }
      },
      child: Container(
        padding: ResponsiveHelper.isDesktop(context)
            ? const EdgeInsets.all(Dimensions.paddingSizeSmall)
            : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          color: ResponsiveHelper.isDesktop(context)
              ? Theme.of(context).cardColor
              : null,
          boxShadow: ResponsiveHelper.isDesktop(context)
              ? [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 1,
                    blurRadius: 5,
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: desktop ? 0 : Dimensions.paddingSizeSmall),
              child: Row(children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    child: CustomImage(
                      image:
                          '${isCampaign ? baseUrls?.campaignImageUrl : isStore ? baseUrls?.storeImageUrl : baseUrls?.itemImageUrl}'
                          '/${isStore ? store?.logo : item?.image}',
                      height: desktop ? 120 : 65,
                      width: desktop ? 120 : 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  DiscountTag(
                    discount: discount ?? 0.0,
                    discountType: discountType,
                    freeDelivery:
                        isStore ? store?.freeDelivery ?? false : false,
                  ),
                  isAvailable
                      ? const SizedBox.shrink()
                      : NotAvailableWidget(isStore: isStore),
                ]),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isStore ? store?.name ?? '' : item?.name ?? 'N/A',
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall),
                          maxLines: desktop ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                            height:
                                isStore ? Dimensions.paddingSizeExtraSmall : 0),
                        (isStore
                                ? store?.address != null
                                : item?.storeName != null)
                            ? Text(
                                isStore
                                    ? store?.address ?? ''
                                    : item?.storeName ?? '',
                                style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  color: Theme.of(context).disabledColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                            height: ((desktop || isStore) &&
                                    (isStore
                                        ? store?.address != null
                                        : item?.storeName != null))
                                ? 5
                                : 0),
                        !isStore
                            ? RatingBar(
                                rating: isStore
                                    ? store?.avgRating?.toDouble() ?? 0.0
                                    : item?.avgRating ?? 0.0,
                                size: desktop ? 15 : 12,
                                ratingCount: isStore
                                    ? store?.ratingCount
                                    : item?.ratingCount,
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                            height: (!isStore && desktop)
                                ? Dimensions.paddingSizeExtraSmall
                                : 0),
                        isStore
                            ? RatingBar(
                                rating: isStore
                                    ? store?.avgRating?.toDouble() ?? 0.0
                                    : item?.avgRating ?? 00,
                                size: desktop ? 15 : 12,
                                ratingCount: isStore
                                    ? store?.ratingCount
                                    : item?.ratingCount,
                              )
                            : Row(children: [
                                Text(
                                  PriceConverter.convertPrice(item?.price ?? 0,
                                      context: context,
                                      discount: discount,
                                      discountType: discountType),
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                                SizedBox(
                                  width: discount != null && discount > 0
                                      ? Dimensions.paddingSizeExtraSmall
                                      : 0,
                                ),
                                discount != null && discount > 0
                                    ? Text(
                                        PriceConverter.convertPrice(
                                            item?.price ?? 0.0,
                                            context: context),
                                        style: robotoMedium.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeExtraSmall,
                                          color:
                                              Theme.of(context).disabledColor,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : const SizedBox.shrink()
                              ]),
                      ]),
                ),
                Column(
                    mainAxisAlignment: isStore
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      !isStore
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    desktop ? Dimensions.paddingSizeSmall : 0,
                              ),
                              child: Icon(Icons.add, size: desktop ? 30 : 25),
                            )
                          : const SizedBox.shrink(),
                      BlocBuilder<WishlistCubit, WishListState>(
                          builder: (context, state) {
                        bool isWished = isStore
                            ? state.wishStoreIdList.contains(store?.id)
                            : state.wishItemIdList.contains(item?.id);

                        return InkWell(
                          onTap: () {
                            // TODO:check item and store null
                            if (store?.id != null && item?.id != null) {
                              if (context.read<AuthBloc>().state.isLoggedIn()) {
                                final wishlistCubit =
                                    context.read<WishlistCubit>();
                                isWished
                                    ? wishlistCubit.removeFromWishList(
                                        isStore ? store!.id! : item!.id,
                                        isStore)
                                    : wishlistCubit.addToWishList(
                                        item, store!, isStore);
                              } else {
                                ShowSnackBar.showSnackBar(context,
                                    title: 'You are not logged In');
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    desktop ? Dimensions.paddingSizeSmall : 0),
                            child: Icon(
                              isWished ? Icons.favorite : Icons.favorite_border,
                              size: desktop ? 30 : 25,
                              color: isWished
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).disabledColor,
                            ),
                          ),
                        );
                      })
                    ]),
              ]),
            )),
            desktop
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(left: desktop ? 130 : 90),
                    child: Divider(
                        color: index == length - 1
                            ? Colors.transparent
                            : Theme.of(context).disabledColor),
                  ),
          ],
        ),
      ),
    );
  }
}
