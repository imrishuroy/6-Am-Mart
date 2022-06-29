import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:six_am_mart/helpers/dimensions.dart';
import 'package:six_am_mart/translations/locale_keys.g.dart';
import 'package:six_am_mart/utils/utils.dart';

class NotAvailableWidget extends StatelessWidget {
  final double fontSize;
  final bool isStore;
  const NotAvailableWidget({Key? key, this.fontSize = 8, this.isStore = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            color: Colors.black.withOpacity(0.6)),
        child: Text(
          isStore
              ? LocaleKeys.closed_now.tr()
              : LocaleKeys.not_available_now_break.tr(),
          textAlign: TextAlign.center,
          style:
              robotoRegular.copyWith(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
