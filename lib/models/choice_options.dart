import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChoiceOptions extends Equatable {
  final String? name;
  final String? title;
  final List<String?> options;

  const ChoiceOptions({
    this.name,
    this.title,
    required this.options,
  });

  ChoiceOptions copyWith({
    String? name,
    String? title,
    List<String?>? options,
  }) {
    return ChoiceOptions(
      name: name ?? this.name,
      title: title ?? this.title,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'options': options,
    };
  }

  factory ChoiceOptions.fromMap(Map<String, dynamic> map) {
    return ChoiceOptions(
      name: map['name'],
      title: map['title'],
      options: List<String?>.from(map['options']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChoiceOptions.fromJson(String source) =>
      ChoiceOptions.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChoiceOptions(name: $name, title: $title, options: $options)';

  @override
  List<Object?> get props => [name, title, options];
}
