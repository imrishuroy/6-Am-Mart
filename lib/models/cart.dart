import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/models/add_ons.dart';
import '/models/variation.dart';

class Cart extends Equatable {
  final int? itemId;
  final int? itemCampaignId;
  final String? price;
  final String? variant;
  final List<Variation?> variation;
  final int? quantity;
  final List<int> addOnIds;
  final List<AddOns?> addOns;
  final List<int?> addOnQtys;

  const Cart({
    this.itemId,
    this.itemCampaignId,
    this.price,
    this.variant,
    required this.variation,
    this.quantity,
    required this.addOnIds,
    required this.addOns,
    required this.addOnQtys,
  });

  Cart copyWith({
    int? itemId,
    int? itemCampaignId,
    String? price,
    String? variant,
    List<Variation?>? variation,
    int? quantity,
    List<int>? addOnIds,
    List<AddOns?>? addOns,
    List<int?>? addOnQtys,
  }) {
    return Cart(
      itemId: itemId ?? this.itemId,
      itemCampaignId: itemCampaignId ?? this.itemCampaignId,
      price: price ?? this.price,
      variant: variant ?? this.variant,
      variation: variation ?? this.variation,
      quantity: quantity ?? this.quantity,
      addOnIds: addOnIds ?? this.addOnIds,
      addOns: addOns ?? this.addOns,
      addOnQtys: addOnQtys ?? this.addOnQtys,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'itemCampaignId': itemCampaignId,
      'price': price,
      'variant': variant,
      'variation': variation.map((x) => x?.toMap()).toList(),
      'quantity': quantity,
      'addOnIds': addOnIds,
      'addOns': addOns.map((x) => x?.toMap()).toList(),
      'addOnQtys': addOnQtys,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      itemId: map['item_id'] != null ? map['item_id'] as int? : null,
      itemCampaignId: map['item_campaign_id'] != null
          ? map['item_campaign_id'] as int
          : null,
      price: map['price'] != null ? map['price'] as String : null,
      variant: map['variant'] != null ? map['variant'] as String : null,
      variation: map['variation'] != null
          ? List<Variation?>.from(
              (map['variation'] as List<int>).map<Variation?>(
                (x) => Variation.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      addOnIds: map['add_on_ids'] != null
          ? List<int>.from((map['add_on_ids'] as List<int>))
          : [],
      addOns: map['add_ons'] != null
          ? List<AddOns?>.from(
              (map['add_ons'] as List<int>).map<AddOns?>(
                (x) => AddOns.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      addOnQtys: map['add_on_qtys'] != null
          ? List<int?>.from((map['add_on_qtys'] as List<int?>))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      itemId,
      itemCampaignId,
      price,
      variant,
      variation,
      quantity,
      addOnIds,
      addOns,
      addOnQtys,
    ];
  }
}
