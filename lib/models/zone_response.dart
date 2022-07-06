import 'package:flutter/foundation.dart';

class ZoneResponseModel {
  final bool? isSuccess;
  final List<int> zoneIds;
  final String message;

  ZoneResponseModel({
    required this.isSuccess,
    required this.zoneIds,
    required this.message,
  });

  ZoneResponseModel copyWith({
    bool? isSuccess,
    List<int>? zoneIds,
    String? message,
  }) {
    return ZoneResponseModel(
      isSuccess: isSuccess ?? this.isSuccess,
      zoneIds: zoneIds ?? this.zoneIds,
      message: message ?? this.message,
    );
  }

  @override
  String toString() =>
      'ZoneResponseModel(isSuccess: $isSuccess, zoneIds: $zoneIds, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ZoneResponseModel &&
        other.isSuccess == isSuccess &&
        listEquals(other.zoneIds, zoneIds) &&
        other.message == message;
  }

  @override
  int get hashCode => isSuccess.hashCode ^ zoneIds.hashCode ^ message.hashCode;
}
