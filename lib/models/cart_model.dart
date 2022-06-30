import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/models/item.dart';
import '/models/variation.dart';
import 'add_on.dart';
import 'add_ons.dart';

class CartModel extends Equatable {
  final double? price;
  final double? discountedPrice;
  final List<Variation?> variation;
  final double? discountAmount;
  final int? quantity;
  final List<AddOn?> addOnIds;
  final List<AddOns?> addOns;
  final bool? isCampaign;
  final int? stock;
  final Item? item;

  const CartModel({
    this.price,
    this.discountedPrice,
    required this.variation,
    this.discountAmount,
    this.quantity,
    required this.addOnIds,
    required this.addOns,
    this.isCampaign,
    this.stock,
    this.item,
  });

  CartModel copyWith({
    double? price,
    double? discountedPrice,
    List<Variation?>? variation,
    double? discountAmount,
    int? quantity,
    List<AddOn?>? addOnIds,
    List<AddOns?>? addOns,
    bool? isCampaign,
    int? stock,
    Item? item,
  }) {
    return CartModel(
      price: price ?? this.price,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      variation: variation ?? this.variation,
      discountAmount: discountAmount ?? this.discountAmount,
      quantity: quantity ?? this.quantity,
      addOnIds: addOnIds ?? this.addOnIds,
      addOns: addOns ?? this.addOns,
      isCampaign: isCampaign ?? this.isCampaign,
      stock: stock ?? this.stock,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'discountedPrice': discountedPrice,
      'variation': variation.map((x) => x?.toMap()).toList(),
      'discountAmount': discountAmount,
      'quantity': quantity,
      'addOnIds': addOnIds.map((x) => x?.toMap()).toList(),
      'addOns': addOns.map((x) => x?.toMap()).toList(),
      'isCampaign': isCampaign,
      'stock': stock,
      'item': item?.toMap(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      price: map['price'] != null ? map['price'] as double : null,
      discountedPrice: map['discounted_price'] != null
          ? map['discounted_price'] as double
          : null,
      variation: List<Variation?>.from(
        (map['variation'] as List<int>).map<Variation?>(
          (x) => Variation.fromMap(x as Map<String, dynamic>),
        ),
      ),
      discountAmount: map['discount_amount'] != null
          ? map['discount_amount'] as double
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      addOnIds: List<AddOn?>.from(
        (map['add_on_ids'] as List<int>).map<AddOn?>(
          (x) => AddOn.fromMap(x as Map<String, dynamic>),
        ),
      ),
      addOns: List<AddOns?>.from(
        (map['add_ons'] as List<int>).map<AddOns?>(
          (x) => AddOns.fromMap(x as Map<String, dynamic>),
        ),
      ),
      isCampaign:
          map['is_campaign'] != null ? map['is_campaign'] as bool : null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      item: map['item'] != null
          ? Item.fromMap(map['item'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      price,
      discountedPrice,
      variation,
      discountAmount,
      quantity,
      addOnIds,
      addOns,
      isCampaign,
      stock,
      item,
    ];
  }
}
