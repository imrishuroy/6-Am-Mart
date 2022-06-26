import 'package:dio/dio.dart';
import '/config/shared_prefs.dart';
import 'exceptions/exceptions.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('REQUEST[${options.method}] => PATH: ${options.path}');

    String? accessToken = SharedPrefs().token;

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      print('User do have token ');
      //dio.interceptors.requestLock.lock();
    }

    // var accessToken = await TokenRepository().getAccessToken();

    // if (accessToken != null) {
    //   var expiration = await TokenRepository().getAccessTokenRemainingTime();

    //   if (expiration.inSeconds < 60) {
    //     dio.interceptors.requestLock.lock();

    //     // Call the refresh endpoint to get a new token
    //     await UserService()
    //         .refresh()
    //         .then((response) async {
    //       await TokenRepository().persistAccessToken(response.accessToken);
    //       accessToken = response.accessToken;
    //     }).catchError((error, stackTrace) {
    //       handler.reject(error, true);
    //     }).whenComplete(() => dio.interceptors.requestLock.unlock());
    //   }

    // }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}
