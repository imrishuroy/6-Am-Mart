import 'dart:convert';

import 'package:equatable/equatable.dart';

class TimeSlotModel extends Equatable {
  final int day;
  final DateTime startTime;
  final DateTime endTime;

  const TimeSlotModel({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  TimeSlotModel copyWith({
    int? day,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return TimeSlotModel(
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
    };
  }

  factory TimeSlotModel.fromMap(Map<String, dynamic> map) {
    return TimeSlotModel(
      day: map['day'] as int,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeSlotModel.fromJson(String source) =>
      TimeSlotModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [day, startTime, endTime];
}
