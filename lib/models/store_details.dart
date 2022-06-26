import 'dart:convert';

import 'package:equatable/equatable.dart';

class StoreDetails extends Equatable {
  final int? id;
  final String? name;
  final List<int?> categoryIds;

  const StoreDetails({
    this.id,
    this.name,
    required this.categoryIds,
  });

  StoreDetails copyWith({
    int? id,
    String? name,
    List<int?>? categoryIds,
  }) {
    return StoreDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryIds: categoryIds ?? this.categoryIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryIds': categoryIds,
    };
  }

  factory StoreDetails.fromMap(Map<String, dynamic> map) {
    return StoreDetails(
      id: map['id']?.toInt(),
      name: map['name'],
      categoryIds: map['category_ids'] != null
          ? List<int?>.from(map['category_ids'])
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreDetails.fromJson(String source) =>
      StoreDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'StoreDetails(id: $id, name: $name, categoryIds: $categoryIds)';

  @override
  List<Object?> get props => [id, name, categoryIds];
}
