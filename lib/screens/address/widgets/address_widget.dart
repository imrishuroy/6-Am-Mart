import 'package:flutter/material.dart';
import '/helpers/dimensions.dart';
import '/helpers/responsive_helper.dart';
import '/models/address_model.dart';
import '/utils/utils.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel address;
  final bool fromAddress;
  final bool fromCheckout;
  final VoidCallback onRemovePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onTap;

  const AddressWidget({
    super.key,
    required this.address,
    required this.fromAddress,
    this.fromCheckout = false,
    required this.onRemovePressed,
    required this.onEditPressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)
              ? Dimensions.paddingSizeDefault
              : Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: fromCheckout ? null : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            border: fromCheckout
                ? Border.all(color: Theme.of(context).disabledColor, width: 1)
                : null,
            boxShadow: fromCheckout
                ? null
                : [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              address.addressType == 'home'
                  ? Icons.home_filled
                  : address.addressType == 'office'
                      ? Icons.work
                      : Icons.location_on,
              size: ResponsiveHelper.isDesktop(context) ? 50 : 40,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      address.addressType ?? '',

                      ///address.addressType.tr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(
                      address.address ?? 'N/A',
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: Theme.of(context).disabledColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
            ),
            // fromAddress ? IconButton(
            //   icon: Icon(Icons.edit, color: Colors.blue, size: ResponsiveHelper.isDesktop(context) ? 35 : 25),
            //   onPressed: onEditPressed,
            // ) : SizedBox(),
            fromAddress
                ? IconButton(
                    icon: Icon(Icons.delete,
                        color: Colors.red,
                        size: ResponsiveHelper.isDesktop(context) ? 35 : 25),
                    onPressed: onRemovePressed,
                  )
                : const SizedBox.shrink(),
          ]),
        ),
      ),
    );
  }
}
