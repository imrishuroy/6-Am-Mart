import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/helpers/dimensions.dart';
import '/models/address_model.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';

class DetailsWidget extends StatelessWidget {
  final String title;
  final AddressModel? address;
  const DetailsWidget({
    Key? key,
    required this.title,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: robotoMedium),
      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      Text(
        address?.contactPersonName ?? 'N/A',
        style: robotoRegular.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: Theme.of(context).primaryColor),
      ),
      Text(
        address?.address ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
      ),
      Wrap(children: [
        if (address?.streetNumber != null && address?.streetNumber != 'N/A')
          Text(
            '${LocaleKeys.street_number.tr()}: ${address?.streetNumber ?? 'N/A'}, ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).hintColor),
          )
        else
          const SizedBox.shrink(),
        if (address?.house != null && address?.house != 'N/A')
          Text(
            '${LocaleKeys.house.tr()}: ${address?.house ?? 'N/A'}, ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).hintColor),
          )
        else
          const SizedBox.shrink(),
        (address?.floor != null && address?.floor != 'N/A')
            ? Text(
                '${LocaleKeys.floor.tr()}: ${address?.floor}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).hintColor),
              )
            : const SizedBox.shrink(),
      ]),
      Text(
        address?.contactPersonNumber ?? 'N/A',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
      ),
    ]);
  }
}
