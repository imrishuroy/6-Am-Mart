import 'dart:convert';

class CartAddOn {
  final int id;
  final int quantity;

  CartAddOn({
    required this.id,
    required this.quantity,
  });

  CartAddOn copyWith({
    int? id,
    int? quantity,
  }) {
    return CartAddOn(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
    };
  }

  factory CartAddOn.fromMap(Map<String, dynamic> map) {
    return CartAddOn(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartAddOn.fromJson(String source) =>
      CartAddOn.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AddOn(id: $id, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartAddOn && other.id == id && other.quantity == quantity;
  }

  @override
  int get hashCode => id.hashCode ^ quantity.hashCode;
}
