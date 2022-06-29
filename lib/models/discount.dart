import 'dart:convert';
import 'package:equatable/equatable.dart';

class Discount extends Equatable {
  final int? id;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final double? minPurchase;
  final double? maxDiscount;
  final double? discount;
  final String? discountType;
  final int? storeId;
  final String? createdAt;
  final String? updatedAt;

  const Discount({
    this.id,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.minPurchase,
    this.maxDiscount,
    this.discount,
    this.discountType,
    this.storeId,
    this.createdAt,
    this.updatedAt,
  });

  Discount copyWith({
    int? id,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    double? minPurchase,
    double? maxDiscount,
    double? discount,
    String? discountType,
    int? storeId,
    String? createdAt,
    String? updatedAt,
  }) {
    return Discount(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      minPurchase: minPurchase ?? this.minPurchase,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      discount: discount ?? this.discount,
      discountType: discountType ?? this.discountType,
      storeId: storeId ?? this.storeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'minPurchase': minPurchase,
      'maxDiscount': maxDiscount,
      'discount': discount,
      'discountType': discountType,
      'storeId': storeId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Discount.fromMap(Map<String, dynamic> map) {
    return Discount(
      id: map['id'] != null ? map['id'] as int : null,
      startDate: map['start_date'] != null ? map['start_date'] as String : null,
      endDate: map['end_date'] != null ? map['end_date'] as String : null,
      startTime: map['start_time'] != null ? map['start_time'] as String : null,
      endTime: map['end_time'] != null ? map['end_time'] as String : null,
      minPurchase:
          map['min_purchase'] != null ? map['min_purchase'] as double : null,
      maxDiscount:
          map['maxDiscount'] != null ? map['maxDiscount'] as double : null,
      discount: map['discount'] != null ? map['discount'] as double : null,
      discountType:
          map['discountType'] != null ? map['discountType'] as String : null,
      storeId: map['storeId'] != null ? map['storeId'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Discount.fromJson(String source) =>
      Discount.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      startDate,
      endDate,
      startTime,
      endTime,
      minPurchase,
      maxDiscount,
      discount,
      discountType,
      storeId,
      createdAt,
      updatedAt,
    ];
  }
}
