import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/blocs/config/app_config_bloc.dart';
import 'package:six_am_mart/helpers/dimensions.dart';
import 'package:six_am_mart/helpers/responsive_helper.dart';
import 'package:six_am_mart/models/add_ons.dart';
import 'package:six_am_mart/models/cart_model.dart';
import 'package:six_am_mart/translations/locale_keys.g.dart';
import 'package:six_am_mart/utils/price_converter.dart';
import 'package:six_am_mart/utils/utils.dart';
import 'package:six_am_mart/widgets/custom_image.dart';
import 'package:six_am_mart/widgets/ratting_bar.dart';

import 'item_bottom_sheet.dart';
import 'quantity_button.dart';

class CartItemWidget extends StatelessWidget {
  final CartModel cart;
  final int cartIndex;
  final List<AddOns> addOns;
  final bool isAvailable;

  const CartItemWidget(
      {Key? key,
      required this.cart,
      required this.cartIndex,
      required this.isAvailable,
      required this.addOns})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<AppConfigBloc>();
    String _addOnText = '';
    int _index = 0;
    List<int> _ids = [];
    List<int> _qtys = [];
    for (var addOn in cart.addOnIds) {
      if (addOn?.id != null) {
        _ids.add(addOn!.id);
        _qtys.add(addOn.quantity);
      }
    }
    // ignore: avoid_function_literals_in_foreach_calls
    cart.item?.addOns.forEach((addOn) {
      if (_ids.contains(addOn?.id)) {
        _addOnText =
            '$_addOnText${(_index == 0) ? '' : ',  '}${addOn?.name} (${_qtys[_index]})';
        _index = _index + 1;
      }
    });

    String _variationText = '';
    if (cart.variation.length > 0) {
      List<String> _variationTypes = cart.variation[0]?.type?.split('-') ?? [];
      if (_variationTypes.length == cart.item?.choiceOptions.length) {
        int _index = 0;
        // ignore: avoid_function_literals_in_foreach_calls
        cart.item?.choiceOptions.forEach((choice) {
          _variationText = '$_variationText${(_index == 0) ? '' : '''
,  '''}${choice?.title} - ${_variationTypes[_index]}';
          _index = _index + 1;
        });
      } else {
        _variationText = cart.item?.variations[0]?.type ?? '';
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      child: InkWell(
        onTap: () {
          ResponsiveHelper.isMobile(context)
              ? showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (con) {
                    if (cart.item != null) {
                      return ItemBottomSheet(
                          item: cart.item!, cartIndex: cartIndex, cart: cart);
                    }

                    return const SizedBox.shrink();
                  })
              : showDialog(
                  context: context,
                  builder: (con) {
                    if (cart.item != null) {
                      return Dialog(
                        child: ItemBottomSheet(
                            item: cart.item!, cartIndex: cartIndex, cart: cart),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
          child: Stack(children: [
            const Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Icon(Icons.delete, color: Colors.white, size: 50),
            ),
            Dismissible(
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) {
                //Get.find<CartController>().removeFromCart(cartIndex),
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeExtraSmall,
                    horizontal: Dimensions.paddingSizeExtraSmall),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      //  Colors.grey[Get.isDarkMode ? 800 : 200],
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSmall),
                            child: CustomImage(
                              image:
                                  '${context.read<AppConfigBloc>().state.configModel?.baseUrls?.itemImageUrl}/${cart.item?.image}',
                              height: 65,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          isAvailable
                              ? const SizedBox.shrink()
                              : Positioned(
                                  top: 0,
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radiusSmall),
                                        color: Colors.black.withOpacity(0.6)),
                                    child: Text(
                                      LocaleKeys.not_available_now_break.tr(),
                                      textAlign: TextAlign.center,
                                      style: robotoRegular.copyWith(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cart.item?.name ?? '',
                                style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeSmall),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              RatingBar(
                                  rating: cart.item?.avgRating ?? 0.0,
                                  size: 12,
                                  ratingCount: cart.item?.ratingCount),
                              const SizedBox(height: 5),
                              Text(
                                PriceConverter.convertPrice(
                                    cart.discountedPrice ??
                                        0.0 + (cart.discountAmount ?? 0.0),
                                    context: context),
                                style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeSmall),
                              ),
                            ]),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ((configBloc.state.configModel?.moduleConfig?.module
                                                ?.unit ==
                                            true &&
                                        cart.item?.unitType != null) ||
                                    (configBloc.state.configModel?.moduleConfig
                                                ?.module?.vegNonVeg ==
                                            true &&
                                        configBloc.state.configModel
                                                ?.toggleVegNonVeg ==
                                            true))
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical:
                                            Dimensions.paddingSizeExtraSmall,
                                        horizontal:
                                            Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusSmall),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Text(
                                      configBloc.state.configModel?.moduleConfig
                                                  ?.module?.unit ==
                                              true
                                          ? cart.item?.unitType ?? ''
                                          : cart.item?.veg == 0
                                              ? LocaleKeys.non_veg.tr()
                                              : LocaleKeys.veg.tr(),
                                      style: robotoRegular.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeExtraSmall,
                                          color: Colors.white),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                                height: configBloc.state.configModel
                                            ?.toggleVegNonVeg ==
                                        true
                                    ? Dimensions.paddingSizeExtraSmall
                                    : 0),
                            Row(children: [
                              QuantityButton(
                                onTap: () {
                                  // if (cart.quantity > 1) {
                                  //   Get.find<CartController>().setQuantity(
                                  //       false, cartIndex, cart.stock);
                                  // } else {
                                  //   Get.find<CartController>()
                                  //       .removeFromCart(cartIndex);
                                  // }
                                },
                                isIncrement: false,
                              ),
                              Text(cart.quantity.toString(),
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge)),
                              QuantityButton(
                                onTap: () {
                                  // Get.find<CartController>()
                                  //     .setQuantity(true, cartIndex, cart.stock);
                                },
                                isIncrement: true,
                              ),
                            ]),
                          ]),
                      !ResponsiveHelper.isMobile(context)
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall),
                              child: IconButton(
                                onPressed: () {
                                  // Get.find<CartController>()
                                  //     .removeFromCart(cartIndex);
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ]),
                    (configBloc.state.configModel?.moduleConfig?.module
                                    ?.addOn ==
                                true &&
                            _addOnText.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: Dimensions.paddingSizeExtraSmall),
                            child: Row(children: [
                              const SizedBox(width: 80),
                              Text('${'addons'.tr}: ',
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall)),
                              Flexible(
                                  child: Text(
                                _addOnText,
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).disabledColor),
                              )),
                            ]),
                          )
                        : const SizedBox.shrink(),
                    (cart.item?.variations.length ?? 0) > 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: Dimensions.paddingSizeExtraSmall),
                            child: Row(children: [
                              const SizedBox(width: 80),
                              Text(LocaleKeys.variations.tr(),
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall)),
                              Flexible(
                                  child: Text(
                                _variationText,
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).disabledColor),
                              )),
                            ]),
                          )
                        : const SizedBox.shrink(),

                    /*addOns.length > 0 ? SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                        itemCount: addOns.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                            child: Row(children: [
                              InkWell(
                                onTap: () {
                                  Get.find<CartController>().removeAddOn(cartIndex, index);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: Icon(Icons.remove_circle, color: Theme.of(context).primaryColor, size: 18),
                                ),
                              ),
                              Text(addOns[index].name, style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                              SizedBox(width: 2),
                              Text(
                                PriceConverter.convertPrice(addOns[index].price),
                                style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                              ),
                              SizedBox(width: 2),
                              Text(
                                '(${cart.addOnIds[index].quantity})',
                                style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                              ),
                            ]),
                          );
                        },
                      ),
                    ) : SizedBox(),*/
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
