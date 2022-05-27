import 'dart:convert';

import 'package:equatable/equatable.dart';

class Module extends Equatable {
  final int? id;
  final String? moduleName;
  final String? moduleType;
  final String? thumbnail;
  final String? status;
  final int? storesCount;
  final String? createdAt;
  final String? updatedAt;
  final String? icon;
  final int? themeId;
  final String? description;
  final List translations;

  const Module({
    this.id,
    this.moduleName,
    this.moduleType,
    this.thumbnail,
    this.status,
    this.storesCount,
    this.createdAt,
    this.updatedAt,
    this.icon,
    this.themeId,
    this.description,
    required this.translations,
  });

  Module copyWith({
    int? id,
    String? moduleName,
    String? moduleType,
    String? thumbnail,
    String? status,
    int? storesCount,
    String? createdAt,
    String? updatedAt,
    String? icon,
    int? themeId,
    String? description,
    List? translations,
  }) {
    return Module(
      id: id ?? this.id,
      moduleName: moduleName ?? this.moduleName,
      moduleType: moduleType ?? this.moduleType,
      thumbnail: thumbnail ?? this.thumbnail,
      status: status ?? this.status,
      storesCount: storesCount ?? this.storesCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      icon: icon ?? this.icon,
      themeId: themeId ?? this.themeId,
      description: description ?? this.description,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'moduleName': moduleName,
      'moduleType': moduleType,
      'thumbnail': thumbnail,
      'status': status,
      'storesCount': storesCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'icon': icon,
      'themeId': themeId,
      'description': description,
      'translations': translations,
    };
  }

  factory Module.fromMap(Map<String, dynamic> map) {
    return Module(
      id: map['id']?.toInt(),
      moduleName: map['module_name'],
      moduleType: map['module_type'],
      thumbnail: map['thumbnail'],
      status: map['status'],
      storesCount: map['stores_count']?.toInt(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      icon: map['icon'],
      themeId: map['theme_id']?.toInt(),
      description: map['description'],
      translations:
          map['translations'] != null ? List.from(map['translations']) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Module.fromJson(String source) => Module.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Module(id: $id, moduleName: $moduleName, moduleType: $moduleType, thumbnail: $thumbnail, status: $status, storesCount: $storesCount, createdAt: $createdAt, updatedAt: $updatedAt, icon: $icon, themeId: $themeId, description: $description, translations: $translations)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      moduleName,
      moduleType,
      thumbnail,
      status,
      storesCount,
      createdAt,
      updatedAt,
      icon,
      themeId,
      description,
      translations,
    ];
  }
}
