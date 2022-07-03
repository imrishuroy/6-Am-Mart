import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'distance.dart';

class Element extends Equatable {
  final Distance? distance;
  final Distance? duration;
  final String? status;

  const Element({
    this.distance,
    this.duration,
    this.status,
  });

  Element copyWith({
    Distance? distance,
    Distance? duration,
    String? status,
  }) {
    return Element(
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

  factory Element.fromMap(Map<String, dynamic> map) {
    return Element(
      distance: map['distance'] != null
          ? Distance.fromMap(map['distance'] as Map<String, dynamic>)
          : null,
      duration: map['duration'] != null
          ? Distance.fromMap(map['duration'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Element.fromJson(String source) =>
      Element.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [distance, duration, status];
}
