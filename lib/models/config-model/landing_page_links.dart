import 'dart:convert';

import 'package:equatable/equatable.dart';

class LandingPageLinks extends Equatable {
  final String? appUrlAndroidStatus;
  final String? appUrlAndroid;
  final String? appUrlIosStatus;
  final String? appUrlIos;

  const LandingPageLinks({
    this.appUrlAndroidStatus,
    this.appUrlAndroid,
    this.appUrlIosStatus,
    this.appUrlIos,
  });

  LandingPageLinks copyWith({
    String? appUrlAndroidStatus,
    String? appUrlAndroid,
    String? appUrlIosStatus,
    String? appUrlIos,
  }) {
    return LandingPageLinks(
      appUrlAndroidStatus: appUrlAndroidStatus ?? this.appUrlAndroidStatus,
      appUrlAndroid: appUrlAndroid ?? this.appUrlAndroid,
      appUrlIosStatus: appUrlIosStatus ?? this.appUrlIosStatus,
      appUrlIos: appUrlIos ?? this.appUrlIos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appUrlAndroidStatus': appUrlAndroidStatus,
      'appUrlAndroid': appUrlAndroid,
      'appUrlIosStatus': appUrlIosStatus,
      'appUrlIos': appUrlIos,
    };
  }

  factory LandingPageLinks.fromMap(Map<String, dynamic> map) {
    return LandingPageLinks(
      appUrlAndroidStatus: map['app_url_android_status'] != null
          ? map['app_url_android_status'] as String
          : null,
      appUrlAndroid: map['app_url_android'] != null
          ? map['app_url_android'] as String
          : null,
      appUrlIosStatus: map['app_url_ios_status'] != null
          ? map['app_url_ios_status'] as String
          : null,
      appUrlIos: map['app_url_ios'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LandingPageLinks.fromJson(String source) =>
      LandingPageLinks.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [appUrlAndroidStatus, appUrlAndroid, appUrlIosStatus, appUrlIos];
}
