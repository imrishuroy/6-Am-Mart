import 'dart:convert';

import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final String? key;
  final String? value;
  const Language({
    this.key,
    this.value,
  });

  Language copyWith({
    String? key,
    String? value,
  }) {
    return Language(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      key: map['key'] != null ? map['key'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) =>
      Language.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [key, value];
}
