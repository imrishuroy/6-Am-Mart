import 'dart:convert';

import 'package:equatable/equatable.dart';

class DeliveryMan extends Equatable {
  final int? id;
  final String? fName;
  final String? lName;
  final String? phone;
  final String? email;
  final String? image;
  final int? zoneId;
  final int? active;
  final int? available;
  final double? avgRating;
  final int? ratingCount;
  final String? lat;
  final String? lng;
  final String? location;
  const DeliveryMan({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.image,
    this.zoneId,
    this.active,
    this.available,
    this.avgRating,
    this.ratingCount,
    this.lat,
    this.lng,
    this.location,
  });

  DeliveryMan copyWith({
    int? id,
    String? fName,
    String? lName,
    String? phone,
    String? email,
    String? image,
    int? zoneId,
    int? active,
    int? available,
    double? avgRating,
    int? ratingCount,
    String? lat,
    String? lng,
    String? location,
  }) {
    return DeliveryMan(
      id: id ?? this.id,
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      image: image ?? this.image,
      zoneId: zoneId ?? this.zoneId,
      active: active ?? this.active,
      available: available ?? this.available,
      avgRating: avgRating ?? this.avgRating,
      ratingCount: ratingCount ?? this.ratingCount,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fName': fName,
      'lName': lName,
      'phone': phone,
      'email': email,
      'image': image,
      'zoneId': zoneId,
      'active': active,
      'available': available,
      'avgRating': avgRating,
      'ratingCount': ratingCount,
      'lat': lat,
      'lng': lng,
      'location': location,
    };
  }

  factory DeliveryMan.fromMap(Map<String, dynamic> map) {
    return DeliveryMan(
      id: map['id'] != null ? map['id'] as int : null,
      fName: map['f_name'] != null ? map['f_name'] as String : null,
      lName: map['l_name'] != null ? map['l_name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      zoneId: map['zone_id'] != null ? map['zone_id'] as int : null,
      active: map['active'] != null ? map['active'] as int : null,
      available: map['available'] != null ? map['available'] as int : null,
      avgRating: map['avg_rating'] != null ? map['avg_rating'] as double : null,
      ratingCount:
          map['rating_count'] != null ? map['rating_count'] as int : null,
      lat: map['lat'] != null ? map['lat'] as String : null,
      lng: map['lng'] != null ? map['lng'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryMan.fromJson(String source) =>
      DeliveryMan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      fName,
      lName,
      phone,
      email,
      image,
      zoneId,
      active,
      available,
      avgRating,
      ratingCount,
      lat,
      lng,
      location,
    ];
  }
}
