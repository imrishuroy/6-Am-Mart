class Urls {
  static const String appName = '6amMart';
  static const double appVersion = 1.1;

  static const String _baseUrl = 'https://6ammart-admin.6amtech.com';

  static const String register = '$_baseUrl/api/v1/auth/register';
  static const String login = '$_baseUrl/api/v1/auth/login';

  static const String customerInfo = '$_baseUrl/api/v1/customer/info';

  static const String catagory = '$_baseUrl/api/v1/categories';
  static const String banner = '$_baseUrl/api/v1/banners';

  static const String module = '$_baseUrl/api/v1/module';

  static const String featuredStores =
      '$_baseUrl/api/v1/stores/get-stores/all?featured=1&offset=1&limit=50';

  // Image Urls

  static const String categoryImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/category/';

  static const String bannerImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/banner/';

  static const String moduleImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/module/';

  static const String storeCoverImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/store/cover/';

  // error image
  static const String errorImage =
      'https://developers.google.com/maps/documentation/streetview/images/error-image-generic.png';
}
