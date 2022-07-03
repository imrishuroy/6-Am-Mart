import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import '/blocs/order/order_cubit.dart';
import '/helpers/dimensions.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';
import '/widgets/loading_indicator.dart';

import 'custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String? description;
  final VoidCallback? onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;
  const ConfirmationDialog(
      {Key? key,
      required this.icon,
      this.title,
      required this.description,
      required this.onYesPressed,
      this.isLogOut = false,
      this.onNoPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: PointerInterceptor(
        child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  child: Image.asset(icon,
                      width: 50,
                      height: 50,
                      color: Theme.of(context).primaryColor),
                ),
                title != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeLarge),
                        child: Text(
                          title ?? '',
                          textAlign: TextAlign.center,
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              color: Colors.red),
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  child: Text(description ?? '',
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
                  return !state.isLoading
                      ? Row(children: [
                          Expanded(
                              child: TextButton(
                            onPressed: () => isLogOut
                                ? onYesPressed
                                : onNoPressed ?? Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.3),
                              minimumSize:
                                  const Size(Dimensions.webMaxWidth, 50),
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSmall)),
                            ),
                            child: Text(
                              isLogOut
                                  ? LocaleKeys.yes.tr()
                                  : LocaleKeys.no.tr(),
                              textAlign: TextAlign.center,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.color),
                            ),
                          )),
                          const SizedBox(width: Dimensions.paddingSizeLarge),
                          Expanded(
                              child: CustomButton(
                            buttonText: isLogOut
                                ? LocaleKeys.no.tr()
                                : LocaleKeys.yes.tr(),
                            onPressed: () => isLogOut
                                ? Navigator.of(context).pop()
                                : onYesPressed,
                            radius: Dimensions.radiusSmall,
                            height: 50,
                          )),
                        ])
                      : const LoadingIndicator();
                })
              ]),
            )),
      ),
    );
  }
}
