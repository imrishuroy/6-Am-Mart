import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? image;
  final int? isPhoneVerified;
  final String? createdAt;
  final String? updatedAt;
  final String? firebaseToken;
  final int? status;
  final int? orderCount;
  final int? memberSinceDays;

  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.image,
    this.isPhoneVerified,
    this.createdAt,
    this.updatedAt,
    this.firebaseToken,
    this.status,
    this.orderCount,
    this.memberSinceDays,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? image,
    int? isPhoneVerified,
    String? createdAt,
    String? updatedAt,
    String? firebaseToken,
    int? status,
    int? orderCount,
    int? memberSinceDays,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      image: image ?? this.image,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      status: status ?? this.status,
      orderCount: orderCount ?? this.orderCount,
      memberSinceDays: memberSinceDays ?? this.memberSinceDays,
    );
  }

  static const emptyUser = User();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'f_name': firstName,
      'l_name': lastName,
      'phone': phone,
      'email': email,
      'image': image,
      'is_phone_verified': isPhoneVerified,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'cm_firebase_token': firebaseToken,
      'status': status,
      'orderCount': orderCount,
      'member_since_days': memberSinceDays,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['f_name'],
      lastName: map['l_name'],
      phone: map['phone'],
      email: map['email'],
      image: map['image'],
      isPhoneVerified: map['is_phone_verified']?.toInt(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      firebaseToken: map['cm_firebase_token'],
      status: map['status']?.toInt(),
      orderCount: map['order_count']?.toInt(),
      memberSinceDays: map['member_since_days']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, image: $image, isPhoneVerified: $isPhoneVerified, createdAt: $createdAt, updatedAt: $updatedAt, firebaseToken: $firebaseToken, status: $status, orderCount: $orderCount, memberSinceDays: $memberSinceDays)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      phone,
      email,
      image,
      isPhoneVerified,
      createdAt,
      updatedAt,
      firebaseToken,
      status,
      orderCount,
      memberSinceDays,
    ];
  }
}
