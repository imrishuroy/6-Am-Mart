import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/models/elements.dart';

class Rows extends Equatable {
  final List<Elements?> elements;

  const Rows({
    required this.elements,
  });

  Rows copyWith({
    List<Elements>? elements,
  }) {
    return Rows(
      elements: elements ?? this.elements,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'elements': elements.map((x) => x?.toMap()).toList(),
    };
  }

  factory Rows.fromMap(Map<String, dynamic> map) {
    return Rows(
      elements: List<Elements>.from(
        (map['elements'] as List<int>).map<Elements>(
          (x) => Elements.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Rows.fromJson(String source) =>
      Rows.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [elements];
}
