import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppBanner extends Equatable {
  final int? id;
  final String? title;
  final String? type;
  final String? image;

  const AppBanner({
    this.id,
    this.title,
    this.type,
    this.image,
  });

  AppBanner copyWith({
    int? id,
    String? title,
    String? type,
    String? image,
  }) {
    return AppBanner(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'image': image,
    };
  }

  factory AppBanner.fromMap(Map<String, dynamic> map) {
    return AppBanner(
      id: map['id']?.toInt(),
      title: map['title'],
      type: map['type'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppBanner.fromJson(String source) =>
      AppBanner.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Banner(id: $id, title: $title, type: $type, image: $image)';
  }

  @override
  List<Object?> get props => [id, title, type, image];
}
