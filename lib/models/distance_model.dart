import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/models/row.dart';

class DistanceModel {
  final List<String?> destinationAddresses;
  final List<String?> originAddresses;
  final List<Rows?> rows;
  final String status;

  DistanceModel({
    required this.destinationAddresses,
    required this.originAddresses,
    required this.rows,
    required this.status,
  });

  DistanceModel copyWith({
    List<String?>? destinationAddresses,
    List<String?>? originAddresses,
    List<Rows?>? rows,
    String? status,
  }) {
    return DistanceModel(
      destinationAddresses: destinationAddresses ?? this.destinationAddresses,
      originAddresses: originAddresses ?? this.originAddresses,
      rows: rows ?? this.rows,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'destination_addresses': destinationAddresses,
      'origin_addresses': originAddresses,
      'rows': rows.map((x) => x?.toMap()).toList(),
      'status': status,
    };
  }

  factory DistanceModel.fromMap(Map<String, dynamic> map) {
    return DistanceModel(
      destinationAddresses: map['destination_addresses'] != null
          ? List<String?>.from((map['destination_addresses'] as List<String?>))
          : [],
      originAddresses: map['origin_addresses'] != null
          ? List<String?>.from((map['origin_addresses'] as List<String?>))
          : [],
      rows: map['row'] != null
          ? List<Rows?>.from(
              (map['rows'] as List<int>).map<Rows?>(
                (x) => Rows.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DistanceModel.fromJson(String source) =>
      DistanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DistanceModel(destinationAddresses: $destinationAddresses, originAddresses: $originAddresses, rows: $rows, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DistanceModel &&
        listEquals(other.destinationAddresses, destinationAddresses) &&
        listEquals(other.originAddresses, originAddresses) &&
        listEquals(other.rows, rows) &&
        other.status == status;
  }

  @override
  int get hashCode {
    return destinationAddresses.hashCode ^
        originAddresses.hashCode ^
        rows.hashCode ^
        status.hashCode;
  }
}
