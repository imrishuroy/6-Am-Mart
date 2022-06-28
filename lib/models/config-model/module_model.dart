import 'dart:convert';

import 'package:equatable/equatable.dart';

class ModuleModel extends Equatable {
  final int? id;
  final String? moduleName;
  final String? moduleType;
  final String? thumbnail;
  final String? icon;
  final int? themeId;
  final String? description;
  final int? storesCount;
  final String? createdAt;
  final String? updatedAt;

  const ModuleModel({
    this.id,
    this.moduleName,
    this.moduleType,
    this.thumbnail,
    this.icon,
    this.themeId,
    this.description,
    this.storesCount,
    this.createdAt,
    this.updatedAt,
  });

  ModuleModel copyWith({
    int? id,
    String? moduleName,
    String? moduleType,
    String? thumbnail,
    String? icon,
    int? themeId,
    String? description,
    int? storesCount,
    String? createdAt,
    String? updatedAt,
  }) {
    return ModuleModel(
      id: id ?? this.id,
      moduleName: moduleName ?? this.moduleName,
      moduleType: moduleType ?? this.moduleType,
      thumbnail: thumbnail ?? this.thumbnail,
      icon: icon ?? this.icon,
      themeId: themeId ?? this.themeId,
      description: description ?? this.description,
      storesCount: storesCount ?? this.storesCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'moduleName': moduleName,
      'moduleType': moduleType,
      'thumbnail': thumbnail,
      'icon': icon,
      'themeId': themeId,
      'description': description,
      'storesCount': storesCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ModuleModel.fromMap(Map<String, dynamic> map) {
    return ModuleModel(
      id: map['id'] != null ? map['id'] as int : null,
      moduleName:
          map['moduleName'] != null ? map['moduleName'] as String : null,
      moduleType:
          map['moduleType'] != null ? map['moduleType'] as String : null,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      themeId: map['themeId'] != null ? map['themeId'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      storesCount:
          map['storesCount'] != null ? map['storesCount'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModuleModel.fromJson(String source) =>
      ModuleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      moduleName,
      moduleType,
      thumbnail,
      icon,
      themeId,
      description,
      storesCount,
      createdAt,
      updatedAt,
    ];
  }
}
