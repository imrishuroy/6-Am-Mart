import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/translations/locale_keys.g.dart';
import '/utils/utils.dart';

import 'footer_view.dart';

class NoDataScreen extends StatelessWidget {
  final bool isCart;
  final bool showFooter;
  final String text;
  const NoDataScreen({
    Key? key,
    required this.text,
    this.isCart = false,
    this.showFooter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FooterView(
        visibility: showFooter,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                isCart ? Images.emptyCart : Images.noDataFound,
                width: MediaQuery.of(context).size.height * 0.15,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                isCart ? LocaleKeys.cart_is_empty.tr() : text,
                style: robotoMedium.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.0175,
                    color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    );
  }
}
