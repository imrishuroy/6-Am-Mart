import 'package:dio/dio.dart';
import 'package:six_am_mart/api/app_inceptor.dart';
import 'package:six_am_mart/config/urls.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: Urls.baseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Map<String, dynamic> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'zoneID': '[1]',
    'moduleID': 1,
    //'X-localization': 'en'
  };

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        receiveTimeout: 15000, // 15 seconds
        connectTimeout: 15000,
        sendTimeout: 15000,
        headers: headers,
      ),
    );

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}
