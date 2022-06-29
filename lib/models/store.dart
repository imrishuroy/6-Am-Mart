import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'discount.dart';
import 'schedules.dart';

class Store extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String logo;
  final String? latitude;
  final String? longitude;
  final String? address;
  final int? minimumOrder;
  final String? currency;
  final bool? freeDelivery;
  final String? coverPhoto;
  final bool? delivery;
  final bool? takeAway;
  final bool? scheduleOrder;
  final int? avgRating;
  final int? tax;
  final int? ratingCount;
  final int? selfDeliverySystem;
  final bool? posSystem;
  final int? deliveryCharge;
  final int? open;
  final bool? active;
  final String? deliveryTime;
  final List<int?>? categoryIds;
  final int? veg;
  final int? nonVeg;
  final int? moduleId;
  final int? orderPlaceToScheduleInterval;
  final Discount? discount;
  final List<Schedules?> schedules;

  const Store({
    this.id,
    this.name,
    this.phone,
    this.email,
    required this.logo,
    this.latitude,
    this.longitude,
    this.address,
    this.minimumOrder,
    this.currency,
    this.freeDelivery,
    this.coverPhoto,
    this.delivery,
    this.takeAway,
    this.scheduleOrder,
    this.avgRating,
    this.tax,
    this.ratingCount,
    this.selfDeliverySystem,
    this.posSystem,
    this.deliveryCharge,
    this.open,
    this.active,
    this.deliveryTime,
    this.categoryIds,
    this.veg,
    this.nonVeg,
    this.moduleId,
    this.orderPlaceToScheduleInterval,
    this.discount,
    required this.schedules,
  });

  Store copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? logo,
    String? latitude,
    String? longitude,
    String? address,
    int? minimumOrder,
    String? currency,
    bool? freeDelivery,
    String? coverPhoto,
    bool? delivery,
    bool? takeAway,
    bool? scheduleOrder,
    int? avgRating,
    int? tax,
    int? ratingCount,
    int? selfDeliverySystem,
    bool? posSystem,
    int? deliveryCharge,
    int? open,
    bool? active,
    String? deliveryTime,
    List<int?>? categoryIds,
    int? veg,
    int? nonVeg,
    int? moduleId,
    int? orderPlaceToScheduleInterval,
    Discount? discount,
    List<Schedules?>? schedules,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      logo: logo ?? this.logo,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      minimumOrder: minimumOrder ?? this.minimumOrder,
      currency: currency ?? this.currency,
      freeDelivery: freeDelivery ?? this.freeDelivery,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      delivery: delivery ?? this.delivery,
      takeAway: takeAway ?? this.takeAway,
      scheduleOrder: scheduleOrder ?? this.scheduleOrder,
      avgRating: avgRating ?? this.avgRating,
      tax: tax ?? this.tax,
      ratingCount: ratingCount ?? this.ratingCount,
      selfDeliverySystem: selfDeliverySystem ?? this.selfDeliverySystem,
      posSystem: posSystem ?? this.posSystem,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      open: open ?? this.open,
      active: active ?? this.active,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      categoryIds: categoryIds ?? this.categoryIds,
      veg: veg ?? this.veg,
      nonVeg: nonVeg ?? this.nonVeg,
      moduleId: moduleId ?? this.moduleId,
      orderPlaceToScheduleInterval:
          orderPlaceToScheduleInterval ?? this.orderPlaceToScheduleInterval,
      discount: discount ?? this.discount,
      schedules: schedules ?? this.schedules,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'logo': logo,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'minimumOrder': minimumOrder,
      'currency': currency,
      'freeDelivery': freeDelivery,
      'coverPhoto': coverPhoto,
      'delivery': delivery,
      'takeAway': takeAway,
      'scheduleOrder': scheduleOrder,
      'avgRating': avgRating,
      'tax': tax,
      'ratingCount': ratingCount,
      'selfDeliverySystem': selfDeliverySystem,
      'posSystem': posSystem,
      'deliveryCharge': deliveryCharge,
      'open': open,
      'active': active,
      'deliveryTime': deliveryTime,
      'categoryIds': categoryIds,
      // categoryIds.map((x) => x?.toMap()).toList(),
      'veg': veg,
      'nonVeg': nonVeg,
      'moduleId': moduleId,
      'orderPlaceToScheduleInterval': orderPlaceToScheduleInterval,
      'discount': discount?.toMap(),
      'schedules': schedules.map((x) => x?.toMap()).toList(),
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        phone: map['phone'] != null ? map['phone'] as String : null,
        email: map['email'] != null ? map['email'] as String : null,
        logo: map['logo'] as String,
        latitude: map['latitude'] != null ? map['latitude'] as String : null,
        longitude: map['longitude'] != null ? map['longitude'] as String : null,
        address: map['address'] != null ? map['address'] as String : null,
        minimumOrder:
            map['minimum_order'] != null ? map['minimum_order'] as int? : null,
        currency: map['currency'] != null ? map['currency'] as String : null,
        freeDelivery:
            map['free_delivery'] != null ? map['free_delivery'] as bool : null,
        coverPhoto:
            map['cover_photo'] != null ? map['cover_photo'] as String : null,
        delivery: map['delivery'] != null ? map['delivery'] as bool : null,
        takeAway: map['take_away'] != null ? map['take_away'] as bool : null,
        scheduleOrder: map['schedule_order'] != null
            ? map['schedule_order'] as bool
            : null,
        avgRating: map['avg_rating'] != null ? map['avg_rating'] as int? : null,
        tax: map['tax'] != null ? map['tax'] as int? : null,
        ratingCount:
            map['rating_count'] != null ? map['rating_count'] as int : null,
        selfDeliverySystem: map['self_delivery_system'] != null
            ? map['self_delivery_system'] as int
            : null,
        posSystem: map['pos_system'] != null ? map['pos_system'] as bool : null,
        deliveryCharge: map['delivery_charge'] != null
            ? map['delivery_charge'] as int?
            : null,
        open: map['open'] != null ? map['open'] as int : null,
        active: map['active'] != null ? map['active'] as bool : null,
        deliveryTime: map['delivery_time'] != null
            ? map['delivery_time'] as String
            : null,
        categoryIds:
            map['category_ids'] != null ? map['category_ids'].cast<int>() : [],
        veg: map['veg'] != null ? map['veg'] as int : null,
        nonVeg: map['non_veg'] != null ? map['non_veg'] as int : null,
        moduleId: map['module_id'] != null ? map['module_id'] as int : null,
        orderPlaceToScheduleInterval:
            map['order_place_to_schedule_interval'] != null
                ? map['order_place_to_schedule_interval'] as int
                : null,
        discount: map['discount'] != null
            ? Discount.fromMap(map['discount'] as Map<String, dynamic>)
            : null,
        schedules: map['schedules'] != null
            ? List<Schedules?>.from(
                (map['schedules'] as List<int?>).map<Schedules?>(
                  (x) => Schedules.fromMap(x as Map<String, dynamic>),
                ),
              )
            : []);
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) =>
      Store.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      phone,
      email,
      logo,
      latitude,
      longitude,
      address,
      minimumOrder,
      currency,
      freeDelivery,
      coverPhoto,
      delivery,
      takeAway,
      scheduleOrder,
      avgRating,
      tax,
      ratingCount,
      selfDeliverySystem,
      posSystem,
      deliveryCharge,
      open,
      active,
      deliveryTime,
      categoryIds,
      veg,
      nonVeg,
      moduleId,
      orderPlaceToScheduleInterval,
      discount,
      schedules,
    ];
  }
}
