import 'dart:convert';

import 'package:equatable/equatable.dart';

class Variation extends Equatable {
  final String? type;
  final double? price;
  final int? stock;

  const Variation({
    this.type,
    this.price,
    this.stock,
  });

  Variation copyWith({
    String? type,
    double? price,
    int? stock,
  }) {
    return Variation(
      type: type ?? this.type,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'price': price,
      'stock': stock,
    };
  }

  factory Variation.fromMap(Map<String, dynamic> map) {
    return Variation(
      type: map['type'],
      price: map['price']?.toDouble(),
      stock: map['stock']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Variation.fromJson(String source) =>
      Variation.fromMap(json.decode(source));

  @override
  String toString() => 'Variation(type: $type, price: $price, stock: $stock)';

  @override
  List<Object?> get props => [type, price, stock];
}
