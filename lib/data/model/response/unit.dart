class Unit {
  final int id;
  final String unit;
  final String createdAt;
  final String updatedAt;

  const Unit({
    this.id,
    this.unit,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit': unit,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id']?.toInt(),
      unit: map['unit'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
