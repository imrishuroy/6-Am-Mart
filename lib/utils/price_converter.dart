import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/config/app_config_bloc.dart';

class PriceConverter {
  static String convertPrice(double price,
      {double? discount, String? discountType, required BuildContext context}) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount') {
        price = price - discount;
      } else if (discountType == 'percent') {
        price = price - ((discount / 100) * price);
      }
    }
    final config = context.read<AppConfigBloc>();
    bool isRightSide = config.state.config?.currencySymbolDirection == 'right';

    return '${isRightSide ? '' : '${config.state.config?.currencySymbol} '}'
        '${(price).toStringAsFixed(config.state.config?.digitAfterDecimalPoint ?? 0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${isRightSide ? ' ${config.state.config?.currencySymbol}' : ''}';
  }

  static double convertWithDiscount(
      double price, double discount, String discountType) {
    if (discountType == 'amount') {
      price = price - discount;
    } else if (discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(
      double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if (type == 'amount') {
      calculatedAmount = discount * quantity;
    } else if (type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(
      String price, String discount, String discountType,
      {required BuildContext context}) {
    return '$discount${discountType == 'percent' ? '%' : context.read<AppConfigBloc>().state.config?.currencySymbol} OFF';
  }
}
