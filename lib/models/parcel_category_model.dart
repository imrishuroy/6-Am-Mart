import 'dart:convert';

import 'package:equatable/equatable.dart';

class ParcelCategoryModel extends Equatable {
  final int? id;
  final String? image;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  const ParcelCategoryModel({
    this.id,
    this.image,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  ParcelCategoryModel copyWith({
    int? id,
    String? image,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return ParcelCategoryModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ParcelCategoryModel.fromMap(Map<String, dynamic> map) {
    return ParcelCategoryModel(
      id: map['id']?.toInt(),
      image: map['image'],
      name: map['name'],
      description: map['description'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelCategoryModel.fromJson(String source) =>
      ParcelCategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParcelCategoryModel(id: $id, image: $image, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      image,
      name,
      description,
      createdAt,
      updatedAt,
    ];
  }
}
