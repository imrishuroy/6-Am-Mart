import 'dart:convert';

import 'package:equatable/equatable.dart';

class LandingPageSettings extends Equatable {
  final String mobileAppSectionImage;
  final String topContentImage;

  const LandingPageSettings({
    required this.mobileAppSectionImage,
    required this.topContentImage,
  });

  LandingPageSettings copyWith({
    String? mobileAppSectionImage,
    String? topContentImage,
  }) {
    return LandingPageSettings(
      mobileAppSectionImage:
          mobileAppSectionImage ?? this.mobileAppSectionImage,
      topContentImage: topContentImage ?? this.topContentImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mobileAppSectionImage': mobileAppSectionImage,
      'topContentImage': topContentImage,
    };
  }

  factory LandingPageSettings.fromMap(Map<String, dynamic> map) {
    return LandingPageSettings(
      mobileAppSectionImage: map['mobile_app_section_image'] as String,
      topContentImage: map['top_content_image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LandingPageSettings.fromJson(String source) =>
      LandingPageSettings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [mobileAppSectionImage, topContentImage];
}
