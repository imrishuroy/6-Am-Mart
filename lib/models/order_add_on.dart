import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderAddOn extends Equatable {
  final String name;
  final double price;
  final int quantity;

  const OrderAddOn({
    required this.name,
    required this.price,
    required this.quantity,
  });

  OrderAddOn copyWith({
    String? name,
    double? price,
    int? quantity,
  }) {
    return OrderAddOn(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderAddOn.fromMap(Map<String, dynamic> map) {
    return OrderAddOn(
      name: map['name'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderAddOn.fromJson(String source) =>
      OrderAddOn.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, price, quantity];
}
