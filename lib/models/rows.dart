import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'elements.dart';

class Row extends Equatable {
  final List<Elements> elements;

  const Row({
    required this.elements,
  });

  Row copyWith({
    List<Elements>? elements,
  }) {
    return Row(
      elements: elements ?? this.elements,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'elements': elements.map((x) => x.toMap()).toList(),
    };
  }

  factory Row.fromMap(Map<String, dynamic> map) {
    return Row(
      elements: map['elements'] != null
          ? List<Elements>.from(
              (map['elements'] as List<int>).map<Elements>(
                (x) => Elements.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Row.fromJson(String source) =>
      Row.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [elements];
}
