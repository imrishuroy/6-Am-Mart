import 'dart:convert';

import 'package:equatable/equatable.dart';

class Unit extends Equatable {
  final int? id;
  final String? unit;
  final String? createdAt;
  final String? updatedAt;

  const Unit({
    this.id,
    this.unit,
    this.createdAt,
    this.updatedAt,
  });

  Unit copyWith({
    int? id,
    String? unit,
    String? createdAt,
    String? updatedAt,
  }) {
    return Unit(
      id: id ?? this.id,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit': unit,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id']?.toInt(),
      unit: map['unit'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Unit(id: $id, unit: $unit, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object?> get props => [id, unit, createdAt, updatedAt];
}
