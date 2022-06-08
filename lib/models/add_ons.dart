import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddOns extends Equatable {
  final int? id;
  final String? name;
  final double? price;

  const AddOns({
    this.id,
    this.name,
    this.price,
  });

  AddOns copyWith({
    int? id,
    String? name,
    double? price,
  }) {
    return AddOns(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory AddOns.fromMap(Map<String, dynamic> map) {
    return AddOns(
      id: map['id']?.toInt(),
      name: map['name'],
      price: map['price']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddOns.fromJson(String source) => AddOns.fromMap(json.decode(source));

  @override
  String toString() => 'AddOns(id: $id, name: $name, price: $price)';

  @override
  List<Object?> get props => [id, name, price];
}
