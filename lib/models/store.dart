import 'dart:convert';

import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? logo;
  final String? coverPhoto;
  final int? avgRating;
  final int? ratingCount;
  final String? address;
  final int? moduleId;

  const Store({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.logo,
    this.coverPhoto,
    this.avgRating,
    this.ratingCount,
    this.address,
    this.moduleId,
  });

  Store copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? logo,
    String? coverPhoto,
    int? avgRating,
    int? ratingCount,
    String? address,
    int? moduleId,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      logo: logo ?? this.logo,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      avgRating: avgRating ?? this.avgRating,
      ratingCount: ratingCount ?? this.ratingCount,
      address: address ?? this.address,
      moduleId: moduleId ?? this.moduleId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'logo': logo,
      'coverPhoto': coverPhoto,
      'avgRating': avgRating,
      'ratingCount': ratingCount,
      'address': address,
      'moduleId': moduleId,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id']?.toInt(),
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      logo: map['logo'],
      coverPhoto: map['cover_photo'],
      avgRating: map['avg_rating']?.toInt(),
      ratingCount: map['rating_count']?.toInt(),
      address: map['address'],
      moduleId: map['module_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) => Store.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Store(id: $id, name: $name, phone: $phone, email: $email, logo: $logo, coverPhoto: $coverPhoto, avgRating: $avgRating, ratingCount: $ratingCount, address: $address , moduleId: $moduleId)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      phone,
      email,
      logo,
      coverPhoto,
      avgRating,
      ratingCount,
      address,
      moduleId,
    ];
  }
}









// import 'package:equatable/equatable.dart';

// class Store extends Equatable {
//   final int? id;
//   final String? name;
//   final String? phone;
//   final String? email;
//   final String? logo;
//   final String? latitude;
//   final String? longitude;
//   final String? address;
//   final String? footerText;
//   final int? minimumOrder;
//   final bool? sheduleOrder;
//   final int? status;
//   final int? vendorId;
//   final String? createdAt;
//   final String? updatedAt;
//   final bool? freeDelivery;
//   final String? coverPhoto;
//   final bool? delivery;
//   final bool? takeAway;
//   final bool? itemSection;
//   final int? tax;
//   final int? tax;
//   final int? zoneId;
//   final bool? reviewsSection;

//   Store(this.id, this.name, this.phone, this.email, this.logo, this.latitude, this.longitude, this.address, this.footerText, this.minimumOrder, this.sheduleOrder, this.status, this.vendorId, this.createdAt, this.updatedAt, this.freeDelivery, this.coverPhoto, this.delivery, this.takeAway, this.itemSection, this.tax, this.tax, this.zoneId, this.reviewsSection);
// }
