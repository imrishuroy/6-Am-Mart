import 'package:equatable/equatable.dart';

class LanguageModel extends Equatable {
  final String imageUrl;
  final String languageName;
  final String languageCode;
  final String countryCode;

  const LanguageModel({
    required this.imageUrl,
    required this.languageName,
    required this.languageCode,
    required this.countryCode,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [imageUrl, languageName, languageCode, countryCode];
}
