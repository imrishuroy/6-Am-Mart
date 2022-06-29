class Urls {
  static const String appName = '6amMart';
  static const double appVersion = 1.1;

  static const String baseUrl = 'https://6ammart-admin.6amtech.com';

  static const String register = '$baseUrl/api/v1/auth/sign-up';
  //'$_baseUrl/api/v1/auth/register';

  static const String login = '$baseUrl/api/v1/auth/login';

  static const String config = '$baseUrl/api/v1/config';

  static const String customerInfo = '$baseUrl/api/v1/customer/info';

  static const String catagory = '$baseUrl/api/v1/categories';
  static const String banner = '$baseUrl/api/v1/banners';

  static const String module = '$baseUrl/api/v1/module';

  static const String featuredStores =
      '$baseUrl/api/v1/stores/get-stores/all?featured=1&offset=1&limit=50';

  static const String popularItemUri = '/api/v1/items/popular';

  static const String reviewedItemUrl = '/api/v1/items/most-reviewed';

  static const String reviewUrl = '/api/v1/items/reviews/submit';

  static const String deliverManReviewUri =
      '/api/v1/delivery-man/reviews/submit';

  static const String itemDetailsUri = '/api/v1/items/details/';

  static const String wishListUri = '/api/v1/customer/wish-list';

  static const String addWishListUri = '/api/v1/customer/wish-list/add?';

  static const String removeWishListUri = '/api/v1/customer/wish-list/remove?';

  static const String popularStore = '$baseUrl/api/v1/stores/popular';

  static const String allStore = '$baseUrl/api/v1/stores/get-stores/all';

  static const storeItem = '$baseUrl/api/v1/items/latest';

  static const storeDetails = '$baseUrl/api/v1/stores/details/';

  static const geoCode = '$baseUrl/api/v1/config/geocode-api';

  static const searchLocation = '$baseUrl/api/v1/config/place-api-autocomplete';

  static const placeDetails = '$baseUrl/api/v1/config/place-api-details';

  static const parcelCategories = '$baseUrl/api/v1/parcel-category';

  // Image Urls

  static const String categoryImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/category/';

  static const String bannerImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/banner/';

  static const String moduleImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/module/';

  static const String storeCoverImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/store/cover/';

  static const String storeLogoImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/store/';

  // error image
  static const String errorImage =
      'https://developers.google.com/maps/documentation/streetview/images/error-image-generic.png';

  static const itemImage =
      'https://6ammart-admin.6amtech.com/storage/app/public/product/';

  static const String parcelCategoryImg =
      'https://6ammart-admin.6amtech.com/storage/app/public/parcel_category/';
}


//