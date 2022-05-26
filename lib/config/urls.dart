class Urls {
  static const String appName = '6amMart';
  static const double appVersion = 1.1;

  static const String _baseUrl = 'https://6ammart-admin.6amtech.com';

  static const String register = '$_baseUrl/api/v1/auth/register';
  static const String login = '$_baseUrl/api/v1/auth/login';

  static const String customerInfo = '$_baseUrl/api/v1/customer/info';

  static const String catagory = '$_baseUrl/api/v1/categories';
  static const String banner = '$_baseUrl/api/v1/banners';
}
