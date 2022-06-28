import 'dart:convert';

import 'package:equatable/equatable.dart';

class DefaultLocation extends Equatable {
  final String? lat;
  final String? lng;

  const DefaultLocation({
    this.lat,
    this.lng,
  });

  DefaultLocation copyWith({
    String? lat,
    String? lng,
  }) {
    return DefaultLocation(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory DefaultLocation.fromMap(Map<String, dynamic> map) {
    return DefaultLocation(
      lat: map['lat'] != null ? map['lat'] as String : null,
      lng: map['lng'] != null ? map['lng'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DefaultLocation.fromJson(String source) =>
      DefaultLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [lat, lng];
}
