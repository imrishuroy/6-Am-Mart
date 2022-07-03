import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/config/app_config_bloc.dart';
import '/blocs/item/item_cubit.dart';
import '/blocs/wishlist/wishlist_cubit.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '../../../models/cart_on.dart';
import '/models/add_ons.dart';
import '/models/cart_model.dart';
import '/models/item.dart';
import '/models/variation.dart';
import '/translations/locale_keys.g.dart';
import '/utils/date_converter.dart';
import '/utils/price_converter.dart';
import '/utils/utils.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_image.dart';
import '/widgets/discount_tag.dart';
import '/widgets/ratting_bar.dart';

import 'quantity_button.dart';

class ItemBottomSheet extends StatefulWidget {
  final Item item;
  final bool isCampaign;
  final CartModel? cart;
  final int? cartIndex;
  final bool inStorePage;

  const ItemBottomSheet({
    Key? key,
    required this.item,
    this.isCampaign = false,
    this.cart,
    this.cartIndex,
    this.inStorePage = false,
  }) : super(key: key);

  @override
  State<ItemBottomSheet> createState() => _ItemBottomSheetState();
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {
  @override
  void initState() {
    super.initState();

    // Get.find<ItemController>().initData(widget.item, widget.cart);
  }

  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<AppConfigBloc>();

    final wishlistCubit = context.read<WishlistCubit>();
    return Container(
        width: 550,
        // margin: EdgeInsets.only(top: Platform .isWeb ? 0 : 30),
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.only(
            left: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: ResponsiveHelper.isMobile(context)
              ? const BorderRadius.vertical(
                  top: Radius.circular(Dimensions.radiusExtraLarge))
              : const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
        ),
        child: BlocBuilder<ItemCubit, ItemState>(
          builder: (context, state) {
            double startingPrice;
            double endingPrice = 0.0;
            if (widget.item.choiceOptions.isNotEmpty) {
              List<double> priceList = [];
              for (var variation in widget.item.variations) {
                priceList.add(variation?.price ?? 0.0);
              }
              priceList.sort((a, b) => a.compareTo(b));
              startingPrice = priceList[0];
              if (priceList[0] < priceList[priceList.length - 1]) {
                endingPrice = priceList[priceList.length - 1];
              }
            } else {
              startingPrice = widget.item.price ?? 0.0;
            }

            List<String> variationList = [];
            for (int index = 0;
                index < widget.item.choiceOptions.length;
                index++) {
              if (widget.item.choiceOptions[index] != null) {
                variationList.add(
                  widget.item.choiceOptions[index]!
                      .options[state.variationIndex[index]]!
                      .replaceAll(' ', ''),
                );
              }
            }
            String variationType = '';
            bool isFirst = true;
            variationList.forEach((variation) {
              if (isFirst) {
                variationType = '$variationType$variation';
                isFirst = false;
              } else {
                variationType = '$variationType-$variation';
              }
            });

            double price = widget.item.price ?? 0.0;
            Variation? variation;
            int stock = widget.item.stock ?? 0;
            for (Variation? variation in widget.item.variations) {
              if (variation?.type == variationType) {
                price = variation?.price ?? 0.0;
                variation = variation;
                stock = variation?.stock ?? 0;
                break;
              }
            }

            double? discount =
                (widget.isCampaign || widget.item.storeDiscount == 0)
                    ? widget.item.discount
                    : widget.item.storeDiscount;
            String? discountType =
                (widget.isCampaign || widget.item.storeDiscount == 0)
                    ? widget.item.discountType
                    : 'percent';
            double priceWithDiscount = PriceConverter.convertWithDiscount(
                price, discount ?? 0.0, discountType ?? 'percent');
            double priceWithQuantity = priceWithDiscount * state.quantity;
            double addonsCost = 0;
            List<CartAddOn> addOnIdList = [];
            List<AddOns> addOnsList = [];
            for (int index = 0; index < widget.item.addOns.length; index++) {
              if (state.addOnActiveList[index]) {
                if (widget.item.addOns[index]?.price != null) {
                  addonsCost = addonsCost +
                      (widget.item.addOns[index]?.price ??
                          1 * state.addOnQtyList[index]);
                }

                addOnIdList.add(CartAddOn(
                    id: widget.item.addOns[index]?.id ?? 1,
                    quantity: state.addOnQtyList[index]));

                if (widget.item.addOns[index] != null) {
                  addOnsList.add(widget.item.addOns[index]!);
                }
              }
            }
            double priceWithAddons = priceWithQuantity +
                (context
                            .read<AppConfigBloc>()
                            .state
                            .configModel
                            ?.moduleConfig
                            ?.module
                            ?.addOn ??
                        false
                    ? addonsCost
                    : 0);
            // bool _isRestAvailable = DateConverter.isAvailable(widget.product.restaurantOpeningTime, widget.product.restaurantClosingTime);
            bool isAvailable = DateConverter.isAvailable(
                context,
                widget.item.availableTimeStarts ?? '',
                widget.item.availableTimeEnds ?? '');

            CartModel cartModel = CartModel(
              variation: variation != null ? [variation] : [],
              addOnIds: addOnIdList,
              addOns: addOnsList,
              price: price,
              discountedPrice: priceWithDiscount,
              discountAmount: (price -
                  PriceConverter.convertWithDiscount(
                      price, discount ?? 0.0, discountType ?? 'percent')),
              quantity: state.quantity,
              isCampaign: widget.isCampaign,
              stock: stock,
              item: widget.item,
            );

            return SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(
                              right: Dimensions.paddingSizeExtraSmall),
                          child: Icon(Icons.close),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        right: Dimensions.paddingSizeDefault,
                        top: ResponsiveHelper.isDesktop(context)
                            ? 0
                            : Dimensions.paddingSizeDefault,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Product
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: widget.isCampaign
                                        ? null
                                        : () {
                                            // TODO : implement that
                                            // if (!widget.isCampaign) {
                                            //   Get.toNamed(
                                            //       RouteHelper.getItemImagesRoute(
                                            //           widget.item));
                                            // }
                                          },
                                    child: Stack(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiusSmall),
                                        child: CustomImage(
                                          image:
                                              '${widget.isCampaign ? configBloc.state.configModel?.baseUrls?.campaignImageUrl : configBloc.state.configModel?.baseUrls?.itemImageUrl}/${widget.item.image}',
                                          width:
                                              ResponsiveHelper.isMobile(context)
                                                  ? 100
                                                  : 140,
                                          height:
                                              ResponsiveHelper.isMobile(context)
                                                  ? 100
                                                  : 140,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      DiscountTag(
                                          discount: discount ?? 0,
                                          discountType: discountType,
                                          fromTop: 20),
                                    ]),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.item.name ?? '',
                                            style: robotoMedium.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (widget.inStorePage) {
                                                // Get.back();
                                                Navigator.of(context).pop();
                                              } else {
                                                /// TODO: implement that
                                                // Get.offNamed(
                                                //     RouteHelper.getStoreRoute(
                                                //         widget.item.storeId,
                                                //         'item'));
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 5, 5),
                                              child: Text(
                                                widget.item.storeName ?? '',
                                                style: robotoRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ),
                                          ),
                                          RatingBar(
                                              rating:
                                                  widget.item.avgRating ?? 0.0,
                                              size: 15,
                                              ratingCount:
                                                  widget.item.ratingCount),
                                          Text(
                                            '${PriceConverter.convertPrice(startingPrice, discount: discount ?? 0.0, discountType: discountType, context: context)}'
                                            '${endingPrice != null ? ' - ${PriceConverter.convertPrice(endingPrice, discount: discount, discountType: discountType, context: context)}' : ''}',
                                            style: robotoMedium.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge),
                                          ),
                                          price > priceWithDiscount
                                              ? Text(
                                                  '${PriceConverter.convertPrice(startingPrice, context: context)}'
                                                  '${endingPrice != null ? ' - ${PriceConverter.convertPrice(endingPrice, context: context)}' : ''}',
                                                  style: robotoMedium.copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                )
                                              : const SizedBox.shrink(),
                                        ]),
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ((context
                                                            .read<
                                                                AppConfigBloc>()
                                                            .state
                                                            .configModel
                                                            ?.moduleConfig
                                                            ?.module
                                                            ?.unit !=
                                                        null &&
                                                    widget.item.unitType !=
                                                        null) ||
                                                (context
                                                            .read<
                                                                AppConfigBloc>()
                                                            .state
                                                            .configModel
                                                            ?.moduleConfig
                                                            ?.module
                                                            ?.vegNonVeg ==
                                                        true &&
                                                    context
                                                            .read<
                                                                AppConfigBloc>()
                                                            .state
                                                            .configModel
                                                            ?.toggleVegNonVeg ==
                                                        true))
                                            ?
                                            // (Get.find<SplashController>()
                                            //         .configModel
                                            //         .moduleConfig
                                            //         .module
                                            //         .vegNonVeg &&
                                            //     Get.find<SplashController>()
                                            //         .configModel
                                            //         .toggleVegNonVeg))
                                            Container(
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    vertical: Dimensions
                                                        .paddingSizeExtraLarge,
                                                    horizontal: Dimensions
                                                        .paddingSizeSmall),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .radiusSmall),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                child: Text(
                                                  context
                                                              .read<
                                                                  AppConfigBloc>()
                                                              .state
                                                              .configModel
                                                              ?.moduleConfig
                                                              ?.module
                                                              ?.unit ==
                                                          true
                                                      ? widget.item.unitType ??
                                                          ''
                                                      : widget.item.veg == 0
                                                          ? LocaleKeys.non_veg
                                                              .tr()
                                                          : LocaleKeys.veg.tr(),
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeExtraSmall,
                                                      color: Colors.white),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        SizedBox(
                                            height: configBloc.state.configModel
                                                        ?.toggleVegNonVeg ==
                                                    true
                                                ? 50
                                                : 0),
                                        widget.isCampaign
                                            ? const SizedBox(height: 25)
                                            : BlocBuilder<WishlistCubit,
                                                    WishListState>(
                                                builder: (context, state) {
                                                return InkWell(
                                                  onTap: () {
                                                    // if(Get.find<AuthController>().isLoggedIn()) {
                                                    //   wishList.wishItemIdList.contains(widget.item.id) ? wishList.removeFromWishList(widget.item.id, false)
                                                    //       : wishList.addToWishList(widget.item, null, false);
                                                    // }else {
                                                    //   showCustomSnackBar('you_are_not_logged_in'.tr);
                                                    // }
                                                  },
                                                  child: Icon(
                                                    wishlistCubit.state
                                                            .wishItemIdList
                                                            .contains(
                                                                widget.item.id)
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: wishlistCubit.state
                                                            .wishItemIdList
                                                            .contains(
                                                                widget.item.id)
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Theme.of(context)
                                                            .disabledColor,
                                                  ),
                                                );
                                              }),

                                        // : GetBuilder<WishListController>(
                                        //     builder: (wishList) {
                                        //     return InkWell(
                                        //       onTap: () {
                                        //         if (Get.find<
                                        //                 AuthController>()
                                        //             .isLoggedIn()) {
                                        //           wishList.wishItemIdList
                                        //                   .contains(widget
                                        //                       .item.id)
                                        //               ? wishList
                                        //                   .removeFromWishList(
                                        //                       widget
                                        //                           .item.id,
                                        //                       false)
                                        //               : wishList
                                        //                   .addToWishList(
                                        //                       widget.item,
                                        //                       null,
                                        //                       false);
                                        //         } else {
                                        //           showCustomSnackBar(
                                        //               'you_are_not_logged_in'
                                        //                   .tr);
                                        //         }
                                        //       },
                                        //       child: Icon(
                                        //         wishList.wishItemIdList
                                        //                 .contains(
                                        //                     widget.item.id)
                                        //             ? Icons.favorite
                                        //             : Icons.favorite_border,
                                        //         color: wishList
                                        //                 .wishItemIdList
                                        //                 .contains(
                                        //                     widget.item.id)
                                        //             ? Theme.of(context)
                                        //                 .primaryColor
                                        //             : Theme.of(context)
                                        //                 .disabledColor,
                                        //       ),
                                        //     );
                                        //   }),
                                      ]),
                                ]),

                            const SizedBox(height: Dimensions.paddingSizeLarge),

                            (widget.item.description != null &&
                                    widget.item.description != '')
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleKeys.description.tr(),
                                          style: robotoMedium),
                                      const SizedBox(
                                          height:
                                              Dimensions.paddingSizeExtraSmall),
                                      Text(widget.item.description ?? '',
                                          style: robotoRegular),
                                      const SizedBox(
                                          height: Dimensions.paddingSizeLarge),
                                    ],
                                  )
                                : const SizedBox.shrink(),

                            // Variation
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.item.choiceOptions.length,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          widget.item.choiceOptions[index]
                                                  ?.title ??
                                              '',
                                          style: robotoMedium),
                                      const SizedBox(
                                          height:
                                              Dimensions.paddingSizeExtraSmall),
                                      GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              ResponsiveHelper.isMobile(context)
                                                  ? 3
                                                  : 4,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: (1 / 0.25),
                                        ),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: widget
                                            .item
                                            .choiceOptions[index]
                                            ?.options
                                            .length,
                                        itemBuilder: (context, i) {
                                          return InkWell(
                                            onTap: () {
                                              // TODO: implement this
                                              // itemController
                                              //     .setCartVariationIndex(
                                              //         index, i, widget.item);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeExtraSmall,
                                              ),
                                              decoration: BoxDecoration(
                                                // color: itemController
                                                //                 .variationIndex[
                                                //             index] !=
                                                //         i
                                                //     ? Theme.of(context)
                                                //         .backgroundColor
                                                //     : Theme.of(context)
                                                //         .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radiusSmall),
                                                // border: itemController
                                                //                 .variationIndex[
                                                //             index] !=
                                                //         i
                                                //     ? Border
                                                //         .all(
                                                //             color: Theme.of(
                                                //                     context)
                                                //                 .disabledColor,
                                                //             width: 2)
                                                //     : null,
                                              ),
                                              child: Text(
                                                widget.item.choiceOptions[index]
                                                        ?.options[i]
                                                        ?.trim() ??
                                                    '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: robotoRegular.copyWith(
                                                    // color: itemController
                                                    //                 .variationIndex[
                                                    //             index] !=
                                                    //         i
                                                    //     ? Colors.black
                                                    //     : Colors.white,
                                                    ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                          height: index !=
                                                  widget.item.choiceOptions
                                                          .length -
                                                      1
                                              ? Dimensions.paddingSizeLarge
                                              : 0),
                                    ]);
                              },
                            ),
                            SizedBox(
                                height: widget.item.choiceOptions.isNotEmpty
                                    ? Dimensions.paddingSizeLarge
                                    : 0),

                            // Quantity
                            Row(children: [
                              Text(LocaleKeys.quantity.tr(),
                                  style: robotoMedium),
                              const Expanded(child: SizedBox()),
                              Row(children: [
                                QuantityButton(
                                  onTap: () {
                                    // if (itemController.quantity > 1) {
                                    //   itemController.setQuantity(false, _stock);
                                    // }
                                  },
                                  isIncrement: false,
                                ),
                                // Text(itemController.quantity.toString(),
                                //     style: robotoMedium.copyWith(
                                //         fontSize: Dimensions.fontSizeLarge)),
                                QuantityButton(
                                  onTap: () {},
                                  // onTap: () =>
                                  //     itemController.setQuantity(true, _stock),
                                  isIncrement: true,
                                ),
                              ]),
                            ]),
                            const SizedBox(height: Dimensions.paddingSizeLarge),

                            // Addons
                            configBloc.state.configModel?.moduleConfig?.module
                                            ?.addOn ==
                                        true &&
                                    widget.item.addOns.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleKeys.addons.tr(),
                                          style: robotoMedium),
                                      const SizedBox(
                                          height:
                                              Dimensions.paddingSizeExtraSmall),
                                      GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: (1 / 1.1),
                                        ),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget.item.addOns.length,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              // TOOD: implement this
                                              // if (!itemController
                                              //     .addOnActiveList[index]) {
                                              //   itemController.addAddOn(
                                              //       true, index);
                                              // } else if (itemController
                                              //         .addOnQtyList[index] ==
                                              //     1) {
                                              //   itemController.addAddOn(
                                              //       false, index);
                                              // }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              // margin: EdgeInsets.only(
                                              // bottom: itemController
                                              //             .addOnActiveList[
                                              //         index]
                                              //     ? 2
                                              //     : 20),
                                              decoration: BoxDecoration(
                                                // color: itemController
                                                //         .addOnActiveList[index]
                                                //     ? Theme.of(context)
                                                //         .primaryColor
                                                //     : Theme.of(context)
                                                //         .backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radiusSmall),
                                              ),
                                              // border: itemController
                                              //         .addOnActiveList[index]
                                              //     ? null
                                              //     : Border.all(
                                              //         color: Theme.of(context)
                                              //             .disabledColor,
                                              //         width: 2),
                                              // boxShadow: itemController
                                              //         .addOnActiveList[index]
                                              //     ? [
                                              //         BoxShadow(
                                              //             color: Colors.grey[
                                              //                 Get.isDarkMode
                                              //                     ? 700
                                              //                     : 300],
                                              //             blurRadius: 5,
                                              //             spreadRadius: 1)
                                              //         ]
                                              //       : null,
                                              // ),
                                              child: Column(children: [
                                                Expanded(
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          widget
                                                                  .item
                                                                  .addOns[index]
                                                                  ?.name ??
                                                              '',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          // style: robotoMedium
                                                          //     .copyWith(
                                                          //   color: itemController
                                                          //               .addOnActiveList[
                                                          //           index]
                                                          //       ? Colors.white
                                                          //       : Colors.black,
                                                          // fontSize: Dimensions
                                                          //     .fontSizeSmall,
                                                          //),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          (widget
                                                                          .item
                                                                          .addOns[
                                                                              index]
                                                                          ?.price ??
                                                                      0) >
                                                                  0
                                                              ? PriceConverter.convertPrice(
                                                                  widget
                                                                          .item
                                                                          .addOns[
                                                                              index]
                                                                          ?.price ??
                                                                      0.0,
                                                                  context:
                                                                      context)
                                                              : LocaleKeys.free
                                                                  .tr(),

                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          // style: robotoRegular
                                                          //     .copyWith(
                                                          //   color: itemController
                                                          //               .addOnActiveList[
                                                          //           index]
                                                          //       ? Colors.white
                                                          //       : Colors.black,
                                                          //   fontSize: Dimensions
                                                          //       .fontSizeExtraSmall,
                                                        ),
                                                        // ),
                                                      ]),
                                                ),

                                                // itemController
                                                //         .addOnActiveList[index]
                                                //     ?

                                                Container(
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radiusSmall),
                                                      color: Theme.of(context)
                                                          .cardColor),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () {
                                                              // if (itemController
                                                              //         .addOnQtyList[index] >
                                                              //     1) {
                                                              //   itemController.setAddOnQuantity(
                                                              //       false,
                                                              //       index);
                                                              // } else {
                                                              //   itemController.addAddOn(
                                                              //       false,
                                                              //       index);
                                                              // }
                                                            },
                                                            child: Center(
                                                                child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 15)),
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   itemController
                                                        //       .addOnQtyList[
                                                        //           index]
                                                        //       .toString(),
                                                        //   style: robotoMedium
                                                        //       .copyWith(
                                                        //           fontSize:
                                                        //               Dimensions.fontSizeSmall),
                                                        // ),
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () {},
                                                            // onTap: () => itemController
                                                            //     .setAddOnQuantity(
                                                            //         true,
                                                            //         index),
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                )
                                                //: SizedBox(),
                                              ]),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                          height:
                                              Dimensions.paddingSizeExtraSmall),
                                    ],
                                  )
                                : const SizedBox.shrink(),

                            Row(children: [
                              Text('${'total_amount'.tr}:',
                                  style: robotoMedium),
                              const SizedBox(
                                  width: Dimensions.paddingSizeExtraSmall),
                              Text(
                                  PriceConverter.convertPrice(priceWithAddons,
                                      context: context),
                                  style: robotoBold.copyWith(
                                      color: Theme.of(context).primaryColor)),
                            ]),
                            const SizedBox(height: Dimensions.paddingSizeLarge),

                            //Add to cart Button

                            isAvailable
                                ? const SizedBox.shrink()
                                : Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    margin: const EdgeInsets.only(
                                        bottom: Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusSmall),
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                    ),
                                    child: Column(children: [
                                      Text(LocaleKeys.not_available_now.tr(),
                                          style: robotoMedium.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: Dimensions.fontSizeLarge,
                                          )),
                                      Text(
                                        '${'available_will_be'.tr} ${DateConverter.convertTimeToTime(widget.item.availableTimeStarts ?? '', context: context)} '
                                        '- ${DateConverter.convertTimeToTime(widget.item.availableTimeEnds ?? '', context: context)}',
                                        style: robotoRegular,
                                      ),
                                    ]),
                                  ),

                            (!(widget.item.scheduleOrder == true) &&
                                    !isAvailable)
                                ? const SizedBox.shrink()
                                : Row(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(50, 50),
                                          primary: Theme.of(context).cardColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSmall,
                                            ),
                                            side: BorderSide(
                                                width: 2,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (widget.inStorePage) {
                                            // Get.back();
                                            Navigator.of(context).pop();
                                          } else {
                                            // Get.offNamed(
                                            //     RouteHelper.getStoreRoute(
                                            //         widget.item.storeId, 'item'));
                                          }
                                        },
                                        child: Image.asset(Images.house,
                                            color:
                                                Theme.of(context).primaryColor,
                                            height: 30,
                                            width: 30),
                                      ),
                                      const SizedBox(
                                          width: Dimensions.paddingSizeSmall),
                                      Expanded(
                                        child: CustomButton(
                                          width: ResponsiveHelper.isDesktop(
                                                  context)
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.0
                                              : null,
                                          /*buttonText: isCampaign ? 'order_now'.tr : isExistInCart ? 'already_added_in_cart'.tr : fromCart
                        ? 'update_in_cart'.tr : 'add_to_cart'.tr,*/
                                          buttonText: configBloc
                                                          .state
                                                          .configModel
                                                          ?.moduleConfig
                                                          ?.module
                                                          ?.stock ==
                                                      true &&
                                                  stock <= 0
                                              ? LocaleKeys.out_of_stock.tr()
                                              : widget.isCampaign
                                                  ? LocaleKeys.order_now.tr()
                                                  : widget.cart != null ||
                                                          state.cartIndex != -1
                                                      ? LocaleKeys
                                                          .update_in_cart
                                                          .tr()
                                                      : LocaleKeys.add_to_cart
                                                          .tr(),

                                          onPressed: () {},

                                          // (Get.find<SplashController>()
                                          //             .configModel
                                          //             .moduleConfig
                                          //             .module
                                          //             .stock &&
                                          //         _stock <= 0)
                                          //     ? null
                                          //     : () {
                                          //         Get.back();
                                          //         if (widget.isCampaign) {
                                          //           Get.toNamed(
                                          //               RouteHelper
                                          //                   .getCheckoutRoute(
                                          //                       'campaign'),
                                          //               arguments: CheckoutScreen(
                                          //                 fromCart: false,
                                          //                 cartList: [_cartModel],
                                          //               ));
                                          //         } else {
                                          //           if (Get.find<CartController>()
                                          //               .existAnotherStoreItem(
                                          //                   _cartModel
                                          //                       .item.storeId)) {
                                          //             Get.dialog(
                                          //                 ConfirmationDialog(
                                          //                   icon: Images.warning,
                                          //                   title:
                                          //                       'are_you_sure_to_reset'
                                          //                           .tr,
                                          //                   description: Get.find<
                                          //                               SplashController>()
                                          //                           .configModel
                                          //                           .moduleConfig
                                          //                           .module
                                          //                           .showRestaurantText
                                          //                       ? 'if_you_continue'
                                          //                           .tr
                                          //                       : 'if_you_continue_without_another_store'
                                          //                           .tr,
                                          //                   onYesPressed: () {
                                          //                     Get.back();
                                          //                     Get.find<
                                          //                             CartController>()
                                          //                         .removeAllAndAddToCart(
                                          //                             _cartModel);
                                          //                     _showCartSnackBar(
                                          //                         context);
                                          //                   },
                                          //                 ),
                                          //                 barrierDismissible:
                                          //                     false);
                                          //           } else {
                                          //             Get.find<CartController>()
                                          //                 .addToCart(
                                          //               _cartModel,
                                          //               widget.cartIndex != null
                                          //                   ? widget.cartIndex
                                          //                   : itemController
                                          //                       .cartIndex,
                                          //             );
                                          //             _showCartSnackBar(context);
                                          //           }
                                          //         }
                                          //       },
                                        ),
                                      ),
                                    ],
                                  ),
                          ]),
                    ),
                  ]),
            );
          },
        ));
  }

  void _showCartSnackBar(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        right: ResponsiveHelper.isDesktop(context)
            ? size.width * 0.7
            : Dimensions.paddingSizeSmall,
        top: Dimensions.paddingSizeSmall,
        bottom: Dimensions.paddingSizeSmall,
        left: Dimensions.paddingSizeSmall,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      content: Text(LocaleKeys.item_added_to_cart.tr(),
          style: robotoMedium.copyWith(color: Colors.white)),
      action: SnackBarAction(
        label: LocaleKeys.view_cart.tr(),
        onPressed: () {
          // Get.toNamed(RouteHelper.getCartRoute()),
        },
        textColor: Colors.white,
      ),
    ));
    // Get.showSnackbar(GetSnackBar(
    //   backgroundColor: Colors.green,
    //   message: 'item_added_to_cart'.tr,
    //   mainButton: TextButton(
    //     onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
    //     child: Text('view_cart'.tr, style: robotoMedium.copyWith(color: Theme.of(context).cardColor)),
    //   ),
    //   onTap: (_) => Get.toNamed(RouteHelper.getCartRoute()),
    //   duration: Duration(seconds: 3),
    //   maxWidth: Dimensions.WEB_MAX_WIDTH,
    //   snackStyle: SnackStyle.FLOATING,
    //   margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    //   borderRadius: 10,
    //   isDismissible: true,
    //   dismissDirection: DismissDirection.horizontal,
    // ));
  }
}
