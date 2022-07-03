import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:six_am_mart/models/order_add_on.dart';

import '/models/item.dart';

import 'cart_on.dart';
import 'variation.dart';

class OrderDetailsModel extends Equatable {
  final int? id;
  final int? itemId;
  final int? orderId;
  final double? price;
  final Item? itemDetails;
  final List<Variation?> variation;
  final List<OrderAddOn?> addOns;
  final double? discountOnItem;
  final String? discountType;
  final int? quantity;
  final double? taxAmount;
  final String? variant;
  final String? createdAt;
  final String? updatedAt;
  final int? itemCampaignId;
  final double? totalAddOnPrice;

  const OrderDetailsModel({
    this.id,
    this.itemId,
    this.orderId,
    this.price,
    this.itemDetails,
    required this.variation,
    required this.addOns,
    this.discountOnItem,
    this.discountType,
    this.quantity,
    this.taxAmount,
    this.variant,
    this.createdAt,
    this.updatedAt,
    this.itemCampaignId,
    this.totalAddOnPrice,
  });

  OrderDetailsModel copyWith({
    int? id,
    int? itemId,
    int? orderId,
    double? price,
    Item? itemDetails,
    List<Variation?>? variation,
    List<OrderAddOn?>? addOns,
    double? discountOnItem,
    String? discountType,
    int? quantity,
    double? taxAmount,
    String? variant,
    String? createdAt,
    String? updatedAt,
    int? itemCampaignId,
    double? totalAddOnPrice,
  }) {
    return OrderDetailsModel(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      orderId: orderId ?? this.orderId,
      price: price ?? this.price,
      itemDetails: itemDetails ?? this.itemDetails,
      variation: variation ?? this.variation,
      addOns: addOns ?? this.addOns,
      discountOnItem: discountOnItem ?? this.discountOnItem,
      discountType: discountType ?? this.discountType,
      quantity: quantity ?? this.quantity,
      taxAmount: taxAmount ?? this.taxAmount,
      variant: variant ?? this.variant,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      itemCampaignId: itemCampaignId ?? this.itemCampaignId,
      totalAddOnPrice: totalAddOnPrice ?? this.totalAddOnPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'itemId': itemId,
      'orderId': orderId,
      'price': price,
      'itemDetails': itemDetails?.toMap(),
      'variation': variation.map((x) => x?.toMap()).toList(),
      'addOns': addOns.map((x) => x?.toMap()).toList(),
      'discountOnItem': discountOnItem,
      'discountType': discountType,
      'quantity': quantity,
      'taxAmount': taxAmount,
      'variant': variant,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'itemCampaignId': itemCampaignId,
      'totalAddOnPrice': totalAddOnPrice,
    };
  }

  factory OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailsModel(
      id: map['id'] != null ? map['id'] as int : null,
      itemId: map['item_id'] != null ? map['item_id'] as int : null,
      orderId: map['order_id'] != null ? map['order_id'] as int : null,
      price: map['price'] != null ? map['price'] as double : null,
      itemDetails: map['item_details'] != null
          ? Item.fromMap(map['item_details'] as Map<String, dynamic>)
          : null,
      variation: map['variation'] != null
          ? List<Variation?>.from(
              (map['variation'] as List<int>).map<Variation?>(
                (x) => Variation.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      addOns: map['add_ons'] != null
          ? List<OrderAddOn?>.from(
              (map['add_ons'] as List<int>).map<CartAddOn?>(
                (x) => CartAddOn.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      discountOnItem: map['discount_on_item'] != null
          ? map['discount_on_item'] as double
          : null,
      discountType:
          map['discount_type'] != null ? map['discount_type'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      taxAmount: map['tax_amount'] != null ? map['tax_amount'] as double : null,
      variant: map['variant'] != null ? map['variant'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      itemCampaignId: map['item_campaign_id'] != null
          ? map['item_campaign_id'] as int
          : null,
      totalAddOnPrice: map['total_add_on_price'] != null
          ? map['total_add_on_price'] as double
          : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      itemId,
      orderId,
      price,
      itemDetails,
      variation,
      addOns,
      discountOnItem,
      discountType,
      quantity,
      taxAmount,
      variant,
      createdAt,
      updatedAt,
      itemCampaignId,
      totalAddOnPrice,
    ];
  }
}
