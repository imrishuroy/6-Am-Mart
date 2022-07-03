import 'dart:convert';

import 'distance.dart';

class Elements {
  final Distance? distance;
  final Distance? duration;
  final String? status;

  Elements({
    required this.distance,
    required this.duration,
    required this.status,
  });

  Elements copyWith({
    Distance? distance,
    Distance? duration,
    String? status,
  }) {
    return Elements(
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'distance': distance?.toMap(),
      'duration': duration?.toMap(),
      'status': status,
    };
  }

  factory Elements.fromMap(Map<String, dynamic> map) {
    return Elements(
      distance: Distance.fromMap(map['distance'] as Map<String, dynamic>),
      duration: Distance.fromMap(map['duration'] as Map<String, dynamic>),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Elements.fromJson(String source) =>
      Elements.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Elements(distance: $distance, duration: $duration, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Elements &&
        other.distance == distance &&
        other.duration == duration &&
        other.status == status;
  }

  @override
  int get hashCode => distance.hashCode ^ duration.hashCode ^ status.hashCode;
}
