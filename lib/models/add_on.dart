import 'dart:convert';

class AddOn {
  final int id;
  final int quantity;

  AddOn({
    required this.id,
    required this.quantity,
  });

  AddOn copyWith({
    int? id,
    int? quantity,
  }) {
    return AddOn(
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

  factory AddOn.fromMap(Map<String, dynamic> map) {
    return AddOn(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddOn.fromJson(String source) =>
      AddOn.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AddOn(id: $id, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddOn && other.id == id && other.quantity == quantity;
  }

  @override
  int get hashCode => id.hashCode ^ quantity.hashCode;
}
