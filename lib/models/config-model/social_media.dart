import 'dart:convert';

import 'package:equatable/equatable.dart';

class SocialMedia extends Equatable {
  final int? id;
  final String? name;
  final String? link;
  final int? status;

  const SocialMedia({
    this.id,
    this.name,
    this.link,
    this.status,
  });

  SocialMedia copyWith({
    int? id,
    String? name,
    String? link,
    int? status,
  }) {
    return SocialMedia(
      id: id ?? this.id,
      name: name ?? this.name,
      link: link ?? this.link,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'link': link,
      'status': status,
    };
  }

  factory SocialMedia.fromMap(Map<String, dynamic> map) {
    return SocialMedia(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialMedia.fromJson(String source) =>
      SocialMedia.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, link, status];
}
