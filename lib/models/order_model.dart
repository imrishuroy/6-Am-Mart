import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/models/address_model.dart';
import 'delivery_man.dart';
import 'parcel_category_model.dart';
import 'store.dart';

class OrderModel extends Equatable {
  final int? id;
  final int? userId;
  final double? orderAmount;
  final double? couponDiscountAmount;
  final String? couponDiscountTitle;
  final String? paymentStatus;
  final String? orderStatus;
  final double? totalTaxAmount;
  final String? paymentMethod;
  final String? couponCode;
  final String? orderNote;
  final String? orderType;
  final String? createdAt;
  final String? updatedAt;
  final double? deliveryCharge;
  final String? scheduleAt;
  final String? otp;
  final String? pending;
  final String? accepted;
  final String? confirmed;
  final String? processing;
  final String? handover;
  final String? pickedUp;
  final String? delivered;
  final String? canceled;
  final String? refundRequested;
  final String? refunded;
  final int? scheduled;
  final double? storeDiscountAmount;
  final String? failed;
  final int? detailsCount;
  final String? orderAttachment;
  final String? chargePayer;
  final String? moduleType;
  final DeliveryMan? deliveryMan;
  final Store? store;
  final AddressModel? deliveryAddress;
  final AddressModel? receiverDetails;
  final ParcelCategoryModel? parcelCategory;

  const OrderModel({
    this.id,
    this.userId,
    this.orderAmount,
    this.couponDiscountAmount,
    this.couponDiscountTitle,
    this.paymentStatus,
    this.orderStatus,
    this.totalTaxAmount,
    this.paymentMethod,
    this.couponCode,
    this.orderNote,
    this.orderType,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharge,
    this.scheduleAt,
    this.otp,
    this.pending,
    this.accepted,
    this.confirmed,
    this.processing,
    this.handover,
    this.pickedUp,
    this.delivered,
    this.canceled,
    this.refundRequested,
    this.refunded,
    this.scheduled,
    this.storeDiscountAmount,
    this.failed,
    this.detailsCount,
    this.orderAttachment,
    this.chargePayer,
    this.moduleType,
    this.deliveryMan,
    this.store,
    this.deliveryAddress,
    this.receiverDetails,
    this.parcelCategory,
  });

  OrderModel copyWith({
    int? id,
    int? userId,
    double? orderAmount,
    double? couponDiscountAmount,
    String? couponDiscountTitle,
    String? paymentStatus,
    String? orderStatus,
    double? totalTaxAmount,
    String? paymentMethod,
    String? couponCode,
    String? orderNote,
    String? orderType,
    String? createdAt,
    String? updatedAt,
    double? deliveryCharge,
    String? scheduleAt,
    String? otp,
    String? pending,
    String? accepted,
    String? confirmed,
    String? processing,
    String? handover,
    String? pickedUp,
    String? delivered,
    String? canceled,
    String? refundRequested,
    String? refunded,
    int? scheduled,
    double? storeDiscountAmount,
    String? failed,
    int? detailsCount,
    String? orderAttachment,
    String? chargePayer,
    String? moduleType,
    DeliveryMan? deliveryMan,
    Store? store,
    AddressModel? deliveryAddress,
    AddressModel? receiverDetails,
    ParcelCategoryModel? parcelCategory,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orderAmount: orderAmount ?? this.orderAmount,
      couponDiscountAmount: couponDiscountAmount ?? this.couponDiscountAmount,
      couponDiscountTitle: couponDiscountTitle ?? this.couponDiscountTitle,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      totalTaxAmount: totalTaxAmount ?? this.totalTaxAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      couponCode: couponCode ?? this.couponCode,
      orderNote: orderNote ?? this.orderNote,
      orderType: orderType ?? this.orderType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      scheduleAt: scheduleAt ?? this.scheduleAt,
      otp: otp ?? this.otp,
      pending: pending ?? this.pending,
      accepted: accepted ?? this.accepted,
      confirmed: confirmed ?? this.confirmed,
      processing: processing ?? this.processing,
      handover: handover ?? this.handover,
      pickedUp: pickedUp ?? this.pickedUp,
      delivered: delivered ?? this.delivered,
      canceled: canceled ?? this.canceled,
      refundRequested: refundRequested ?? this.refundRequested,
      refunded: refunded ?? this.refunded,
      scheduled: scheduled ?? this.scheduled,
      storeDiscountAmount: storeDiscountAmount ?? this.storeDiscountAmount,
      failed: failed ?? this.failed,
      detailsCount: detailsCount ?? this.detailsCount,
      orderAttachment: orderAttachment ?? this.orderAttachment,
      chargePayer: chargePayer ?? this.chargePayer,
      moduleType: moduleType ?? this.moduleType,
      deliveryMan: deliveryMan ?? this.deliveryMan,
      store: store ?? this.store,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      receiverDetails: receiverDetails ?? this.receiverDetails,
      parcelCategory: parcelCategory ?? this.parcelCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'orderAmount': orderAmount,
      'couponDiscountAmount': couponDiscountAmount,
      'couponDiscountTitle': couponDiscountTitle,
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'totalTaxAmount': totalTaxAmount,
      'paymentMethod': paymentMethod,
      'couponCode': couponCode,
      'orderNote': orderNote,
      'orderType': orderType,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deliveryCharge': deliveryCharge,
      'scheduleAt': scheduleAt,
      'otp': otp,
      'pending': pending,
      'accepted': accepted,
      'confirmed': confirmed,
      'processing': processing,
      'handover': handover,
      'pickedUp': pickedUp,
      'delivered': delivered,
      'canceled': canceled,
      'refundRequested': refundRequested,
      'refunded': refunded,
      'scheduled': scheduled,
      'storeDiscountAmount': storeDiscountAmount,
      'failed': failed,
      'detailsCount': detailsCount,
      'orderAttachment': orderAttachment,
      'chargePayer': chargePayer,
      'moduleType': moduleType,
      'deliveryMan': deliveryMan?.toMap(),
      'store': store?.toMap(),
      'deliveryAddress': deliveryAddress?.toMap(),
      'receiverDetails': receiverDetails?.toMap(),
      'parcelCategory': parcelCategory?.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      orderAmount:
          map['order_amount'] != null ? map['order_amount'] as double : null,
      couponDiscountAmount: map['coupon_discount_amount'] != null
          ? map['coupon_discount_amount'] as double
          : null,
      couponDiscountTitle: map['coupon_discount_title'] != null
          ? map['coupon_discount_title'] as String
          : null,
      paymentStatus: map['payment_status'] != null
          ? map['payment_status'] as String
          : null,
      orderStatus:
          map['order_status'] != null ? map['order_status'] as String : null,
      totalTaxAmount: map['total_tax_amount'] != null
          ? map['total_tax_amount'] as double
          : null,
      paymentMethod: map['payment_method'] != null
          ? map['payment_method'] as String
          : null,
      couponCode:
          map['coupon_code'] != null ? map['coupon_code'] as String : null,
      orderNote: map['order_note'] != null ? map['order_note'] as String : null,
      orderType: map['order_type'] != null ? map['order_type'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      deliveryCharge: map['delivery_charge'] != null
          ? map['delivery_charge'] as double
          : null,
      scheduleAt:
          map['schedule_at'] != null ? map['schedule_at'] as String : null,
      otp: map['otp'] != null ? map['otp'] as String : null,
      pending: map['pending'] != null ? map['pending'] as String : null,
      accepted: map['accepted'] != null ? map['accepted'] as String : null,
      confirmed: map['confirmed'] != null ? map['confirmed'] as String : null,
      processing:
          map['processing'] != null ? map['processing'] as String : null,
      handover: map['handover'] != null ? map['handover'] as String : null,
      pickedUp: map['pickedUp'] != null ? map['pickedUp'] as String : null,
      delivered: map['delivered'] != null ? map['delivered'] as String : null,
      canceled: map['canceled'] != null ? map['canceled'] as String : null,
      refundRequested: map['refund_requested'] != null
          ? map['refund_requested'] as String
          : null,
      refunded: map['refunded'] != null ? map['refunded'] as String : null,
      scheduled: map['scheduled'] != null ? map['scheduled'] as int : null,
      storeDiscountAmount: map['store_discount_amount'] != null
          ? map['store_discount_amount'] as double
          : null,
      failed: map['failed'] != null ? map['failed'] as String : null,
      detailsCount: map['detadetails_countilsCount'] != null
          ? map['details_count'] as int
          : null,
      orderAttachment: map['order_attachment'] != null
          ? map['order_attachment'] as String
          : null,
      chargePayer:
          map['charge_payer'] != null ? map['charge_payer'] as String : null,
      moduleType:
          map['module_type'] != null ? map['module_type'] as String : null,
      deliveryMan: map['delivery_man'] != null
          ? DeliveryMan.fromMap(map['delivery_man'] as Map<String, dynamic>)
          : null,
      store: map['store'] != null
          ? Store.fromMap(map['store'] as Map<String, dynamic>)
          : null,
      deliveryAddress: map['delivery_address'] != null
          ? AddressModel.fromMap(
              map['delivery_address'] as Map<String, dynamic>)
          : null,
      receiverDetails: map['receiver_details'] != null
          ? AddressModel.fromMap(
              map['receiver_details'] as Map<String, dynamic>)
          : null,
      parcelCategory: map['parcel_category'] != null
          ? ParcelCategoryModel.fromMap(
              map['parcel_category'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      orderAmount,
      couponDiscountAmount,
      couponDiscountTitle,
      paymentStatus,
      orderStatus,
      totalTaxAmount,
      paymentMethod,
      couponCode,
      orderNote,
      orderType,
      createdAt,
      updatedAt,
      deliveryCharge,
      scheduleAt,
      otp,
      pending,
      accepted,
      confirmed,
      processing,
      handover,
      pickedUp,
      delivered,
      canceled,
      refundRequested,
      refunded,
      scheduled,
      storeDiscountAmount,
      failed,
      detailsCount,
      orderAttachment,
      chargePayer,
      moduleType,
      deliveryMan,
      store,
      deliveryAddress,
      receiverDetails,
      parcelCategory,
    ];
  }
}
