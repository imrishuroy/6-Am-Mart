import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/config/shared_prefs.dart';
import '/config/urls.dart';
import '/models/failure.dart';

import '/repositories/location/base_location_repo.dart';

class LocationRepository extends BaseLocationRepository {
  final Dio _dio;

  LocationRepository({Dio? dio}) : _dio = dio ?? Dio();
  final Map<String, String> _mainHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'zoneID': '[1]',
    'moduleID': '1',
    'Authorization': 'Bearer ${SharedPrefs().token}'
  };

  Future<Response> getData(
    String url, {
    required Map<String, dynamic> query,
    required Map<String, String> headers,
  }) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $url\nHeader: $_mainHeaders');
      }

      print('check header ( header ) --$headers');
      print('check header ( mainheader ) -- $_mainHeaders');

      print('check header ( url ) ---- $url');

      final response = await _dio.get(Urls.baseUrl + url);
      // .timeout(const Duration(seconds: 30));

      // Http.Response _response = await Http.get(
      //   Uri.parse(appBaseUrl + uri),
      //   headers: headers ?? _mainHeaders,
      // ).timeout(Duration(seconds: timeoutInSeconds));
      // return handleResponse(_response, uri);
      return response;
    } catch (e) {
      print('------------${e.toString()}');
      throw const Failure(message: 'Somthing went wrong');
      // return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  // final Map<String, String> _mainHeaders = {
  //   // 'Content-Type': 'application/json; charset=UTF-8',
  //   // AppConstants.ZONE_ID: zoneIDs != null ? jsonEncode(zoneIDs) : null,
  //   // AppConstants.LOCALIZATION_KEY:
  //   //     languageCode ?? AppConstants.languages[0].languageCode,
  //   // 'Authorization': 'Bearer $token'
  //   'Content-Type': 'application/json; charset=UTF-8',
  //   'zoneID': '[1]',
  //   'moduleID': '1',
  //   'Authorization': 'Bearer ${SharedPrefs().token}'
  // };

  // Response handleResponse(Response response, String uri) {
  //   dynamic _body;
  //   try {
  //     _body = response.data;
  //   } catch (e) {
  //     print('Error getting response data ${e.toString()}');
  //   }
  //   Response _response = Response(

  //     data: _body ?? response.data,
  //     requestOptions: RequestOptions(path: response.)

  //     // bodyString: response.body.toString(),
  //     // request: Request(
  //     //     headers: response.request.headers,
  //     //     method: response.request.method,
  //     //     url: response.request.url),
  //     // headers: response.headers,
  //     // statusCode: response.statusCode,
  //     // statusText: response.reasonPhrase,
  //   );
  //   if (_response.statusCode != 200 &&
  //       _response.body != null &&
  //       _response.body is! String) {
  //     if (_response.body.toString().startsWith('{errors: [{code:')) {
  //       ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
  //       _response = Response(
  //           statusCode: _response.statusCode,
  //           body: _response.body,
  //           statusText: _errorResponse.errors[0].message);
  //     } else if (_response.body.toString().startsWith('{message')) {
  //       _response = Response(
  //           statusCode: _response.statusCode,
  //           body: _response.body,
  //           statusText: _response.body['message']);
  //     }
  //   } else if (_response.statusCode != 200 && _response.body == null) {
  //     _response = Response(statusCode: 0, statusText: noInternetMessage);
  //   }
  //   if (Foundation.kDebugMode) {
  //     print(
  //         '====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
  //   }
  //   return _response;
  // }
}
