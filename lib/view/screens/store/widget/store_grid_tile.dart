import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/wishlist_controller.dart';
import 'package:sixam_mart/data/model/response/config_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/screens/store/store_screen.dart';

class StoreGridTile extends StatelessWidget {
  final List<Item> items;
  final List<Store> stores;
  final bool isStore;
  final EdgeInsetsGeometry padding;
  final bool isScrollable;
  final int shimmerLength;
  final String noDataText;
  final bool isCampaign;
  final bool inStorePage;
  final String type;
  final bool isFeatured;
  final bool showTheme1Store;
  final Function(String type) onVegFilterTap;

  StoreGridTile(
      {@required this.stores,
      @required this.items,
      @required this.isStore,
      this.isScrollable = false,
      this.shimmerLength = 20,
      this.padding = const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      this.noDataText,
      this.isCampaign = false,
      this.inStorePage = false,
      this.type,
      this.onVegFilterTap,
      this.isFeatured = false,
      this.showTheme1Store = false});

  @override
  Widget build(BuildContext context) {
    bool _isNull = true;
    int _length = 0;
    if (isStore) {
      _isNull = stores == null;
      if (!_isNull) {
        _length = stores.length;
      }
    } else {
      _isNull = items == null;
      if (!_isNull) {
        _length = items.length;
      }
    }
    return GridView.builder(
        itemCount: _length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.9,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return StoreItemWidget(
            index: index,
            isStore: isStore,
            length: _length,
            item: isStore ? null : items[index],
          );

          // ItemWidget(
          //   isStore: isStore,
          //   item: isStore ? null : items[index],
          //   store: isStore ? stores[index] : null,
          //   index: index,
          //   length: _length,
          //   isCampaign: isCampaign,
          //   inStore: inStorePage,
          // );
        });
  }
}

class StoreItemWidget extends StatelessWidget {
  final Item item;
  final Store store;
  final bool isStore;
  final int index;
  final int length;
  final bool inStore;
  final bool isCampaign;
  final bool isFeatured;

  const StoreItemWidget({
    Key key,
    this.item,
    @required this.isStore,
    this.store,
    @required this.index,
    @required this.length,
    this.inStore = false,
    this.isCampaign = false,
    this.isFeatured = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaseUrls _baseUrls = Get.find<SplashController>().configModel.baseUrls;
    bool _desktop = ResponsiveHelper.isDesktop(context);
    double _discount;
    String _discountType;
    bool _isAvailable;
    if (isStore) {
      _discount = store.discount != null ? store.discount.discount : 0;
      _discountType =
          store.discount != null ? store.discount.discountType : 'percent';
      // bool _isClosedToday = Get.find<StoreController>().isRestaurantClosed(true, store.active, store.offDay);
      // _isAvailable = DateConverter.isAvailable(store.openingTime, store.closeingTime) && store.active && !_isClosedToday;
      _isAvailable = store.open == 1 && store.active;
    } else {
      _discount = (item.storeDiscount == 0 || isCampaign)
          ? item.discount
          : item.storeDiscount;
      _discountType = (item.storeDiscount == 0 || isCampaign)
          ? item.discountType
          : 'percent';
      _isAvailable = DateConverter.isAvailable(
          item.availableTimeStarts, item.availableTimeEnds);
    }

    // final config = context.read<AppConfigBloc>();
    // BaseUrls? baseUrls = config.state.configModel?.baseUrls;

    bool desktop = ResponsiveHelper.isDesktop(context);
    double discount;
    String discountType;
    bool isAvailable;
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
                  item.availableTimeStarts, item.availableTimeEnds)
              : false;
      // DateConverter.isAvailable(
      //     context: context, item.availableTimeStarts, item.availableTimeEnds);
    }

    return InkWell(
      onTap: () {
        if (isStore) {
          Get.toNamed(
            RouteHelper.getStoreRoute(store.id, isFeatured ? 'module' : 'item'),
            arguments: StoreScreen(store: store, fromModule: isFeatured),
          );
        } else {
          Get.find<ItemController>().navigateToItemPage(item, context,
              inStore: inStore, isCampaign: isCampaign);
        }
      },
      child: SizedBox(
        // width: 175.0,
        child: Stack(
          fit: StackFit.loose,
          children: [
            SizedBox(
              width: 168.0,
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
                        child: CustomImage(
                          image:
                              '${isCampaign ? _baseUrls.campaignImageUrl : isStore ? _baseUrls.storeImageUrl : _baseUrls.itemImageUrl}'
                              '/${isStore ? store.logo : item.image}',
                          height: _desktop ? 120 : 65,
                          width: _desktop ? 120 : 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      //             // ),
                      // DisplayImage(
                      //   imageUrl: imgUrl,
                      //   height: 120,
                      //   width: 120.0,
                      //   fit: BoxFit.cover,
                      // ),
                      //),
                      SizedBox(
                        height: 34.0,
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
                        '${item.unit.id} ${item.unitType}',
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
                                  PriceConverter.convertPrice(item?.price ?? 0,
                                      // context: context,
                                      discount: discount,
                                      discountType: discountType),
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                                // Text(
                                //   '₹${price ?? item?.price ?? 'N/A'}',
                                //   // '₹${item?.price ?? 0.0)} * (item?.discount ?? 1)}',
                                //   style: const TextStyle(
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                              ],
                            ),
                          ),

                          GetBuilder<WishListController>(
                              builder: (wishController) {
                            bool _isWished = isStore
                                ? wishController.wishStoreIdList
                                    .contains(store.id)
                                : wishController.wishItemIdList
                                    .contains(item.id);
                            return InkWell(
                              onTap: () {
                                if (Get.find<AuthController>().isLoggedIn()) {
                                  _isWished
                                      ? wishController.removeFromWishList(
                                          isStore ? store.id : item.id, isStore)
                                      : wishController.addToWishList(
                                          item, store, isStore);
                                } else {
                                  showCustomSnackBar(
                                      'you_are_not_logged_in'.tr);
                                }
                              },
                              child: Icon(
                                _isWished
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: _desktop ? 30 : 25,
                                color: _isWished
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).disabledColor,
                              ),
                            );
                          }),
                          // GestureDetector(
                          //   onTap: () {
                          //     print('Price -- ${item?.price}');
                          //     print('DIscount -- ${item?.discount}');

                          //    // Get.find<CartController>().addToCart(cartModel, index);

                          //     // final CartModel cartModel = CartModel(
                          //     //   price: item?.price,
                          //     //   discountedPrice: (item?.price ?? 0) -
                          //     //       (item?.discount ?? 0),
                          //     //   variation: const [],
                          //     //   addOnIds: const [],
                          //     //   addOns: const [],
                          //     //   item: item,
                          //     //   quantity: 1,
                          //     // );

                          //     // context.read<CartCubit>().addToCart(cartModel,
                          //     //     context.read<ItemCubit>().state.cartIndex);

                          //     // ShowSnackBar.showSnackBar(
                          //     //   context,
                          //     //   backgroundColor: Colors.green,
                          //     //   title: LocaleKeys.item_added_to_cart.tr(),
                          //     // );
                          //   },
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //       horizontal: 9.0,
                          //       vertical: 7.0,
                          //     ),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(20.0),
                          //       border: Border.all(
                          //           color: Colors.grey.shade300, width: 0.5),
                          //     ),
                          //     child: Row(
                          //       children: const [
                          //         Icon(
                          //           Icons.add,
                          //           color: Colors.green,
                          //           size: 20.0,
                          //         ),
                          //         SizedBox(width: 1.0),
                          //         Text(
                          //           'ADD',
                          //           style: TextStyle(
                          //             color: Colors.green,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                      //price
                      // + button
                    ],
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
                    // SvgPicture.asset(
                    //   'assets/svgs/hexagon.svg',
                    //   color: green,
                    //   height: 40.0,
                    //   width: 40.0,
                    // ),

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
              )
          ],
        ),
      ),

      // Container(
      //   padding: ResponsiveHelper.isDesktop(context)
      //       ? const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL)
      //       : null,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
      //     color: ResponsiveHelper.isDesktop(context)
      //         ? Theme.of(context).cardColor
      //         : null,
      //     boxShadow: ResponsiveHelper.isDesktop(context)
      //         ? [
      //             BoxShadow(
      //               color: Colors.grey.shade300,
      //               spreadRadius: 1,
      //               blurRadius: 5,
      //             )
      //           ]
      //         : null,
      //   ),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Expanded(
      //           child: Padding(
      //         padding: EdgeInsets.symmetric(
      //             vertical: desktop ? 0 : Dimensions.PADDING_SIZE_SMALL),
      //         child: Row(children: [
      //           Stack(children: [
      //             ClipRRect(
      //               borderRadius:
      //                   BorderRadius.circular(Dimensions.RADIUS_SMALL),
      //               child: CustomImage(
      //                 image:
      //                     '${isCampaign ? _baseUrls.campaignImageUrl : isStore ? _baseUrls.storeImageUrl : _baseUrls.itemImageUrl}'
      //                     '/${isStore ? store.logo : item.image}',
      //                 height: _desktop ? 120 : 65,
      //                 width: _desktop ? 120 : 80,
      //                 fit: BoxFit.cover,
      //               ),
      //             ),

      //             //   CustomImage(
      //             //     image:
      //             //         '${isCampaign ? baseUrls?.campaignImageUrl : isStore ? baseUrls?.storeImageUrl : baseUrls?.itemImageUrl}'
      //             //         '/${isStore ? store?.logo : item?.image}',
      //             //     height: desktop ? 120 : 65,
      //             //     width: desktop ? 120 : 80,
      //             //     fit: BoxFit.cover,
      //             //   ),
      //             // ),
      //             DiscountTag(
      //               discount: discount ?? 0.0,
      //               discountType: discountType,
      //               freeDelivery:
      //                   isStore ? store?.freeDelivery ?? false : false,
      //             ),
      //             isAvailable
      //                 ? const SizedBox.shrink()
      //                 : NotAvailableWidget(isStore: isStore),
      //           ]),
      //           const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
      //           Expanded(
      //             child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     isStore ? store?.name ?? '' : item?.name ?? 'N/A',
      //                     style: robotoMedium.copyWith(
      //                         fontSize: Dimensions.fontSizeSmall),
      //                     maxLines: desktop ? 2 : 1,
      //                     overflow: TextOverflow.ellipsis,
      //                   ),
      //                   SizedBox(
      //                       height: isStore
      //                           ? Dimensions.PADDING_SIZE_EXTRA_SMALL
      //                           : 0),
      //                   (isStore
      //                           ? store?.address != null
      //                           : item?.storeName != null)
      //                       ? Text(
      //                           isStore
      //                               ? store?.address ?? ''
      //                               : item?.storeName ?? '',
      //                           style: robotoRegular.copyWith(
      //                             fontSize: Dimensions.fontSizeExtraSmall,
      //                             color: Theme.of(context).disabledColor,
      //                           ),
      //                           maxLines: 1,
      //                           overflow: TextOverflow.ellipsis,
      //                         )
      //                       : const SizedBox.shrink(),
      //                   SizedBox(
      //                       height: ((desktop || isStore) &&
      //                               (isStore
      //                                   ? store?.address != null
      //                                   : item?.storeName != null))
      //                           ? 5
      //                           : 0),
      //                   !isStore
      //                       ? RatingBar(
      //                           rating: isStore
      //                               ? store?.avgRating?.toDouble() ?? 0.0
      //                               : item?.avgRating ?? 0.0,
      //                           size: desktop ? 15 : 12,
      //                           ratingCount: isStore
      //                               ? store?.ratingCount
      //                               : item?.ratingCount,
      //                         )
      //                       : const SizedBox.shrink(),
      //                   SizedBox(
      //                       height: (!isStore && desktop)
      //                           ? Dimensions.PADDING_SIZE_EXTRA_SMALL
      //                           : 0),
      //                   isStore
      //                       ? RatingBar(
      //                           rating: isStore
      //                               ? store?.avgRating?.toDouble() ?? 0.0
      //                               : item?.avgRating ?? 00,
      //                           size: desktop ? 15 : 12,
      //                           ratingCount: isStore
      //                               ? store?.ratingCount
      //                               : item?.ratingCount,
      //                         )
      //                       : Row(children: [
      //                           Text(
      //                             PriceConverter.convertPrice(item?.price ?? 0,
      //                                 // context: context,
      //                                 discount: discount,
      //                                 discountType: discountType),
      //                             style: robotoMedium.copyWith(
      //                                 fontSize: Dimensions.fontSizeSmall),
      //                           ),
      //                           SizedBox(
      //                             width: discount != null && discount > 0
      //                                 ? Dimensions.PADDING_SIZE_EXTRA_SMALL
      //                                 : 0,
      //                           ),
      //                           discount != null && discount > 0
      //                               ? Text(
      //                                   PriceConverter.convertPrice(
      //                                     item?.price ?? 0.0,
      //                                   ),
      //                                   style: robotoMedium.copyWith(
      //                                     fontSize:
      //                                         Dimensions.fontSizeExtraSmall,
      //                                     color:
      //                                         Theme.of(context).disabledColor,
      //                                     decoration:
      //                                         TextDecoration.lineThrough,
      //                                   ),
      //                                 )
      //                               : const SizedBox.shrink()
      //                         ]),
      //                 ]),
      //           ),
      //           Column(
      //               mainAxisAlignment: isStore
      //                   ? MainAxisAlignment.center
      //                   : MainAxisAlignment.spaceBetween,
      //               children: [
      //                 !isStore
      //                     ? Padding(
      //                         padding: EdgeInsets.symmetric(
      //                           vertical:
      //                               desktop ? Dimensions.PADDING_SIZE_SMALL : 0,
      //                         ),
      //                         child: Icon(Icons.add, size: desktop ? 30 : 25),
      //                       )
      //                     : const SizedBox.shrink(),
      //                 GetBuilder<WishListController>(builder: (wishController) {
      //                   bool _isWished = isStore
      //                       ? wishController.wishStoreIdList.contains(store.id)
      //                       : wishController.wishItemIdList.contains(item.id);
      //                   return InkWell(
      //                     onTap: () {
      //                       if (Get.find<AuthController>().isLoggedIn()) {
      //                         _isWished
      //                             ? wishController.removeFromWishList(
      //                                 isStore ? store.id : item.id, isStore)
      //                             : wishController.addToWishList(
      //                                 item, store, isStore);
      //                       } else {
      //                         showCustomSnackBar('you_are_not_logged_in'.tr);
      //                       }
      //                     },
      //                     child: Padding(
      //                       padding: EdgeInsets.symmetric(
      //                           vertical: _desktop
      //                               ? Dimensions.PADDING_SIZE_SMALL
      //                               : 0),
      //                       child: Icon(
      //                         _isWished
      //                             ? Icons.favorite
      //                             : Icons.favorite_border,
      //                         size: _desktop ? 30 : 25,
      //                         color: _isWished
      //                             ? Theme.of(context).primaryColor
      //                             : Theme.of(context).disabledColor,
      //                       ),
      //                     ),
      //                   );
      //                 }),

      //                 // BlocBuilder<WishlistCubit, WishListState>(
      //                 //     builder: (context, state) {
      //                 //   bool isWished = isStore
      //                 //       ? state.wishStoreIdList.contains(store?.id)
      //                 //       : state.wishItemIdList.contains(item?.id);

      //                 //   return InkWell(
      //                 //     onTap: () {
      //                 //       // TODO:check item and store null
      //                 //       if (store?.id != null && item?.id != null) {
      //                 //         if (context.read<AuthBloc>().state.isLoggedIn()) {
      //                 //           final wishlistCubit =
      //                 //               context.read<WishlistCubit>();
      //                 //           isWished
      //                 //               ? wishlistCubit.removeFromWishList(
      //                 //                   isStore ? store!.id! : item!.id,
      //                 //                   isStore)
      //                 //               : wishlistCubit.addToWishList(
      //                 //                   item, store!, isStore);
      //                 //         } else {
      //                 //           ShowSnackBar.showSnackBar(context,
      //                 //               title: 'You are not logged In');
      //                 //         }
      //                 //       }
      //                 //     },
      //                 //     child: Padding(
      //                 //       padding: EdgeInsets.symmetric(
      //                 //           vertical:
      //                 //               desktop ? Dimensions.paddingSizeSmall : 0),
      //                 //       child: Icon(
      //                 //         isWished ? Icons.favorite : Icons.favorite_border,
      //                 //         size: desktop ? 30 : 25,
      //                 //         color: isWished
      //                 //             ? Theme.of(context).primaryColor
      //                 //             : Theme.of(context).disabledColor,
      //                 //       ),
      //                 //     ),
      //                 //   );
      //                 // })
      //               ]),
      //         ]),
      //       )),
      //       desktop
      //           ? const SizedBox.shrink()
      //           : Padding(
      //               padding: EdgeInsets.only(left: desktop ? 130 : 90),
      //               child: Divider(
      //                   color: index == length - 1
      //                       ? Colors.transparent
      //                       : Theme.of(context).disabledColor),
      //             ),
      //     ],
      //   ),
      // ),
    );
  }
}
