import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppCategory extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final int? parentId;
  final int? position;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final int? priority;
  final int? moduleId;
  const AppCategory({
    this.id,
    this.name,
    this.image,
    this.parentId,
    this.position,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.priority,
    this.moduleId,
  });

  AppCategory copyWith({
    int? id,
    String? name,
    String? image,
    int? parentId,
    int? position,
    int? status,
    String? createdAt,
    String? updatedAt,
    int? priority,
    int? moduleId,
  }) {
    return AppCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      parentId: parentId ?? this.parentId,
      position: position ?? this.position,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      priority: priority ?? this.priority,
      moduleId: moduleId ?? this.moduleId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'parentId': parentId,
      'position': position,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'priority': priority,
      'moduleId': moduleId,
    };
  }

  factory AppCategory.fromMap(Map<String, dynamic> map) {
    return AppCategory(
      id: map['id']?.toInt(),
      name: map['name'],
      image: map['image'],
      parentId: map['parent_id']?.toInt(),
      position: map['position']?.toInt(),
      status: map['status']?.toInt(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      priority: map['priority']?.toInt(),
      moduleId: map['module_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppCategory.fromJson(String source) =>
      AppCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, image: $image, parentId: $parentId, position: $position, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, priority: $priority, moduleId: $moduleId)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      image,
      parentId,
      position,
      status,
      createdAt,
      updatedAt,
      priority,
      moduleId,
    ];
  }
}
