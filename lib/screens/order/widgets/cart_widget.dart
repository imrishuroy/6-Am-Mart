import 'package:flutter/material.dart';
import '/helpers/dimensions.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final bool showCard;
  const CardWidget({Key? key, required this.child, this.showCard = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          showCard ? const EdgeInsets.all(Dimensions.paddingSizeSmall) : null,
      decoration: showCard
          ? BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5)
              ],
            )
          : null,
      child: child,
    );
  }
}
