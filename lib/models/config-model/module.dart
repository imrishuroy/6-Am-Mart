import 'dart:convert';

import 'package:equatable/equatable.dart';

class Module extends Equatable {
  final bool? orderPlaceToScheduleInterval;
  final bool? addOn;
  final bool? stock;
  final bool? vegNonVeg;
  final bool? unit;
  final bool? orderAttachment;
  final bool? showRestaurantText;
  final bool? isParcel;
  final String? description;

  const Module({
    this.orderPlaceToScheduleInterval,
    this.addOn,
    this.stock,
    this.vegNonVeg,
    this.unit,
    this.orderAttachment,
    this.showRestaurantText,
    this.isParcel,
    this.description,
  });

  Module copyWith({
    bool? orderPlaceToScheduleInterval,
    bool? addOn,
    bool? stock,
    bool? vegNonVeg,
    bool? unit,
    bool? orderAttachment,
    bool? showRestaurantText,
    bool? isParcel,
    String? description,
  }) {
    return Module(
      orderPlaceToScheduleInterval:
          orderPlaceToScheduleInterval ?? this.orderPlaceToScheduleInterval,
      addOn: addOn ?? this.addOn,
      stock: stock ?? this.stock,
      vegNonVeg: vegNonVeg ?? this.vegNonVeg,
      unit: unit ?? this.unit,
      orderAttachment: orderAttachment ?? this.orderAttachment,
      showRestaurantText: showRestaurantText ?? this.showRestaurantText,
      isParcel: isParcel ?? this.isParcel,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderPlaceToScheduleInterval': orderPlaceToScheduleInterval,
      'addOn': addOn,
      'stock': stock,
      'vegNonVeg': vegNonVeg,
      'unit': unit,
      'orderAttachment': orderAttachment,
      'showRestaurantText': showRestaurantText,
      'isParcel': isParcel,
      'description': description,
    };
  }

  factory Module.fromMap(Map<String, dynamic> map) {
    return Module(
      orderPlaceToScheduleInterval: map['orderPlaceToScheduleInterval'] != null
          ? map['orderPlaceToScheduleInterval'] as bool
          : null,
      addOn: map['addOn'] != null ? map['addOn'] as bool : null,
      stock: map['stock'] != null ? map['stock'] as bool : null,
      vegNonVeg: map['vegNonVeg'] != null ? map['vegNonVeg'] as bool : null,
      unit: map['unit'] != null ? map['unit'] as bool : null,
      orderAttachment: map['orderAttachment'] != null
          ? map['orderAttachment'] as bool
          : null,
      showRestaurantText: map['showRestaurantText'] != null
          ? map['showRestaurantText'] as bool
          : null,
      isParcel: map['isParcel'] != null ? map['isParcel'] as bool : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Module.fromJson(String source) =>
      Module.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      orderPlaceToScheduleInterval,
      addOn,
      stock,
      vegNonVeg,
      unit,
      orderAttachment,
      showRestaurantText,
      isParcel,
      description,
    ];
  }
}
