import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryIds extends Equatable {
  final String? id;
  const CategoryIds({
    this.id,
  });

  CategoryIds copyWith({
    String? id,
  }) {
    return CategoryIds(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory CategoryIds.fromMap(Map<String, dynamic> map) {
    return CategoryIds(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryIds.fromJson(String source) =>
      CategoryIds.fromMap(json.decode(source));

  @override
  String toString() => 'CategoryIds(id: $id)';

  @override
  List<Object?> get props => [id];
}
