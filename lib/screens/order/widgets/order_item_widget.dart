import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/config/app_config_bloc.dart';
import '/helpers/dimensions.dart';
import '/models/order_details_model.dart';
import '/models/order_model.dart';
import '/translations/locale_keys.g.dart';
import '/utils/price_converter.dart';
import '/utils/utils.dart';
import '/widgets/custom_image.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel? order;
  final OrderDetailsModel? orderDetails;
  const OrderItemWidget(
      {Key? key, required this.order, required this.orderDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<AppConfigBloc>();
    String addOnText = '';
    for (var addOn in orderDetails?.addOns ?? []) {
      addOnText =
          '$addOnText${(addOnText.isEmpty) ? '' : ',  '}${addOn?.name} (${addOn?.quantity})';
    }

    String variationText = '';
    if ((orderDetails?.variation.length ?? 0) > 0) {
      List<String?>? variationTypes =
          orderDetails?.variation[0]?.type?.split('-');
      if (variationTypes?.length ==
          orderDetails?.itemDetails?.choiceOptions.length) {
        int index = 0;
        for (var choice in orderDetails?.itemDetails?.choiceOptions ?? []) {
          variationText =
              '$variationText${(index == 0) ? '' : ',  '}${choice?.title} - ${variationTypes?[index]}';
          index = index + 1;
        }
      } else {
        variationText = orderDetails?.itemDetails?.variations[0]?.type ?? 'N/A';
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          child: CustomImage(
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            image:
                '${orderDetails?.itemCampaignId != null ? configBloc.state.configModel?.baseUrls?.campaignImageUrl : configBloc.state.configModel?.baseUrls?.itemImageUrl}/'
                '${orderDetails?.itemDetails?.image}',
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(
                orderDetails?.itemDetails?.name ?? '',
                style:
                    robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
              Text(LocaleKeys.quantity.tr(),
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall)),
              Text(
                '${orderDetails?.quantity ?? 'N/A'}',
                style: robotoMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeSmall),
              ),
            ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(children: [
              Expanded(
                  child: Text(
                orderDetails?.price != null
                    ? PriceConverter.convertPrice(orderDetails!.price!,
                        context: context)
                    : 'N/A',
                style: robotoMedium,
              )),
              ((configBloc.state.configModel?.moduleConfig?.module?.unit ==
                              true &&
                          orderDetails?.itemDetails?.unitType != null) ||
                      (configBloc.state.configModel?.moduleConfig?.module
                                  ?.vegNonVeg ==
                              true &&
                          configBloc.state.configModel?.toggleVegNonVeg ==
                              true))
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall,
                          horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        configBloc.state.configModel?.moduleConfig?.module
                                    ?.unit ==
                                true
                            ? orderDetails?.itemDetails?.unitType ?? ''
                            : orderDetails?.itemDetails?.veg == 0
                                ? LocaleKeys.non_veg.tr()
                                : LocaleKeys.veg.tr(),
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: Colors.white),
                      ),
                    )
                  : const SizedBox.shrink(),
            ]),
          ]),
        ),
      ]),
      (configBloc.state.configModel?.moduleConfig?.module?.addOn == true &&
              addOnText.isNotEmpty)
          ? Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
              child: Row(children: [
                const SizedBox(width: 60),
                Text(LocaleKeys.addons.tr(),
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall)),
                Flexible(
                    child: Text(addOnText,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).disabledColor,
                        ))),
              ]),
            )
          : const SizedBox.shrink(),
      (orderDetails?.itemDetails?.variations.length ?? 0) > 0
          ? Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
              child: Row(children: [
                const SizedBox(width: 60),
                Text(LocaleKeys.variations.tr(),
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall)),
                Flexible(
                    child: Text(variationText,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).disabledColor,
                        ))),
              ]),
            )
          : const SizedBox.shrink(),
      const Divider(height: Dimensions.paddingSizeLarge),
      const SizedBox(height: Dimensions.paddingSizeSmall),
    ]);
  }
}
