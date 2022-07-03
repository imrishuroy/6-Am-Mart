import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/models/address_model.dart';
import '/models/cart.dart';

class PlaceOrderBody extends Equatable {
  final List<Cart?> cart;
  final double? couponDiscountAmount;
  final double? orderAmount;
  final String? orderType;
  final String? paymentMethod;
  final String? orderNote;
  final String? couponCode;
  final int? storeId;
  final double? distance;
  final String? scheduleAt;
  final double? discountAmount;
  final double? taxAmount;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final AddressModel? receiverDetails;
  final String? addressType;
  final String? parcelCategoryId;
  final String? chargePayer;
  final String? streetNumber;
  final String? house;
  final String? floor;
  const PlaceOrderBody({
    required this.cart,
    this.couponDiscountAmount,
    this.orderAmount,
    this.orderType,
    this.paymentMethod,
    this.orderNote,
    this.couponCode,
    this.storeId,
    this.distance,
    this.scheduleAt,
    this.discountAmount,
    this.taxAmount,
    this.address,
    this.latitude,
    this.longitude,
    this.contactPersonName,
    this.contactPersonNumber,
    this.receiverDetails,
    this.addressType,
    this.parcelCategoryId,
    this.chargePayer,
    this.streetNumber,
    this.house,
    this.floor,
  });

  PlaceOrderBody copyWith({
    List<Cart?>? cart,
    double? couponDiscountAmount,
    double? orderAmount,
    String? orderType,
    String? paymentMethod,
    String? orderNote,
    String? couponCode,
    int? storeId,
    double? distance,
    String? scheduleAt,
    double? discountAmount,
    double? taxAmount,
    String? address,
    String? latitude,
    String? longitude,
    String? contactPersonName,
    String? contactPersonNumber,
    AddressModel? receiverDetails,
    String? addressType,
    String? parcelCategoryId,
    String? chargePayer,
    String? streetNumber,
    String? house,
    String? floor,
  }) {
    return PlaceOrderBody(
      cart: cart ?? this.cart,
      couponDiscountAmount: couponDiscountAmount ?? this.couponDiscountAmount,
      orderAmount: orderAmount ?? this.orderAmount,
      orderType: orderType ?? this.orderType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderNote: orderNote ?? this.orderNote,
      couponCode: couponCode ?? this.couponCode,
      storeId: storeId ?? this.storeId,
      distance: distance ?? this.distance,
      scheduleAt: scheduleAt ?? this.scheduleAt,
      discountAmount: discountAmount ?? this.discountAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      contactPersonName: contactPersonName ?? this.contactPersonName,
      contactPersonNumber: contactPersonNumber ?? this.contactPersonNumber,
      receiverDetails: receiverDetails ?? this.receiverDetails,
      addressType: addressType ?? this.addressType,
      parcelCategoryId: parcelCategoryId ?? this.parcelCategoryId,
      chargePayer: chargePayer ?? this.chargePayer,
      streetNumber: streetNumber ?? this.streetNumber,
      house: house ?? this.house,
      floor: floor ?? this.floor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cart': cart.map((x) => x?.toMap()).toList(),
      'couponDiscountAmount': couponDiscountAmount,
      'orderAmount': orderAmount,
      'orderType': orderType,
      'paymentMethod': paymentMethod,
      'orderNote': orderNote,
      'couponCode': couponCode,
      'storeId': storeId,
      'distance': distance,
      'scheduleAt': scheduleAt,
      'discountAmount': discountAmount,
      'taxAmount': taxAmount,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'contactPersonName': contactPersonName,
      'contactPersonNumber': contactPersonNumber,
      'receiverDetails': receiverDetails?.toMap(),
      'addressType': addressType,
      'parcelCategoryId': parcelCategoryId,
      'chargePayer': chargePayer,
      'streetNumber': streetNumber,
      'house': house,
      'floor': floor,
    };
  }

  factory PlaceOrderBody.fromMap(Map<String, dynamic> map) {
    return PlaceOrderBody(
      cart: map['cart'] != null
          ? List<Cart?>.from(
              (map['cart'] as List<int>).map<Cart?>(
                (x) => Cart.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      couponDiscountAmount: map['coupon_discount_amount'] != null
          ? map['coupon_discount_amount'] as double
          : null,
      orderAmount:
          map['order_amount'] != null ? map['order_amount'] as double : null,
      orderType: map['order_type'] != null ? map['order_type'] as String : null,
      paymentMethod: map['payment_method'] != null
          ? map['payment_method'] as String
          : null,
      orderNote: map['order_note'] != null ? map['order_note'] as String : null,
      couponCode:
          map['coupon_code'] != null ? map['coupon_code'] as String : null,
      storeId: map['store_id'] != null ? map['store_id'] as int : null,
      distance: map['distance'] != null ? map['distance'] as double : null,
      scheduleAt:
          map['schedule_at'] != null ? map['schedule_at'] as String : null,
      discountAmount: map['discount_amount'] != null
          ? map['discount_amount'] as double
          : null,
      taxAmount: map['tax_amount'] != null ? map['tax_amount'] as double : null,
      address: map['address'] != null ? map['address'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      contactPersonName: map['contact_person_name'] != null
          ? map['contact_person_name'] as String
          : null,
      contactPersonNumber: map['contact_person_number'] != null
          ? map['contact_person_number'] as String
          : null,
      receiverDetails: map['receiver_details'] != null
          ? AddressModel.fromMap(
              map['receiver_details'] as Map<String, dynamic>)
          : null,
      addressType:
          map['address_type'] != null ? map['address_type'] as String : null,
      parcelCategoryId: map['parcel_category_id'] != null
          ? map['parcel_category_id'] as String
          : null,
      chargePayer:
          map['charge_payer'] != null ? map['charge_payer'] as String : null,
      streetNumber: map['road'] != null ? map['road'] as String : null,
      house: map['house'] != null ? map['house'] as String : null,
      floor: map['floor'] != null ? map['floor'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceOrderBody.fromJson(String source) =>
      PlaceOrderBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      cart,
      couponDiscountAmount,
      orderAmount,
      orderType,
      paymentMethod,
      orderNote,
      couponCode,
      storeId,
      distance,
      scheduleAt,
      discountAmount,
      taxAmount,
      address,
      latitude,
      longitude,
      contactPersonName,
      contactPersonNumber,
      receiverDetails,
      addressType,
      parcelCategoryId,
      chargePayer,
      streetNumber,
      house,
      floor,
    ];
  }
}
