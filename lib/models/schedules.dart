// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Schedules extends Equatable {
  final int? id;
  final int? storeId;
  final int? day;
  final String? openingTime;
  final String? closingTime;

  const Schedules({
    this.id,
    this.storeId,
    this.day,
    this.openingTime,
    this.closingTime,
  });

  Schedules copyWith({
    int? id,
    int? storeId,
    int? day,
    String? openingTime,
    String? closingTime,
  }) {
    return Schedules(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      day: day ?? this.day,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'storeId': storeId,
      'day': day,
      'openingTime': openingTime,
      'closingTime': closingTime,
    };
  }

  factory Schedules.fromMap(Map<String, dynamic> map) {
    return Schedules(
      id: map['id'] != null ? map['id'] as int : null,
      storeId: map['store_id'] != null ? map['store_id'] as int : null,
      day: map['day'] != null ? map['day'] as int : null,
      openingTime:
          map['opening_time'] != null ? map['opening_time'] as String : null,
      closingTime:
          map['closing_time'] != null ? map['closing_time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedules.fromJson(String source) =>
      Schedules.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      storeId,
      day,
      openingTime,
      closingTime,
    ];
  }
}
