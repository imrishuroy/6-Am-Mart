import '/models/language_model.dart';
import '/utils/utils.dart';

class AppConstants {
  static const String appName = '6amMart';
  static const double appVersion = 1.4;

  static const String theme = '6ammart_theme';
  static const String token = '6ammart_token';
  static const String countryCode = '6ammart_country_code';
  static const String languageCode = '6ammart_language_code';
  static const String cartList = '6ammart_cart_list';
  static const String userPassword = '6ammart_user_password';
  static const String userAddress = '6ammart_user_address';
  static const String userNumber = '6ammart_user_number';
  static const String userCountryCode = '6ammart_user_country_code';
  static const String notification = '6ammart_notification';
  static const String searchHistory = '6ammart_search_history';
  static const String intro = '6ammart_intro';

  static const String notificationCount = '6ammart_notification_count';

  static const String topic = 'all_zone_customer';
  static const String zoneID = 'zoneId';
  static const String moduleID = 'moduleId';
  static const String localizationKey = 'X-localization';

  static List<LanguageModel> languages = const [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'عربى',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];
}
