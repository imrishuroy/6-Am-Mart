import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:six_am_mart/api/api.dart';
import 'package:six_am_mart/models/place_details_model.dart';
import 'package:six_am_mart/models/prediction_model.dart';
import '/config/shared_prefs.dart';
import '/config/urls.dart';
import '/models/failure.dart';

import '/repositories/location/base_location_repo.dart';

import 'package:geolocator/geolocator.dart';

class LocationRepository extends BaseLocationRepository {
  final Dio _dio;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddressFromLatLng({
    required double lat,
    required double lng,
  }) async {
    try {
      String address = 'Unknown Location Found';
      final params = {
        'lat': lat,
        'lng': lng,
      };
      final response =
          await Api.createDio().get(Urls.geoCode, queryParameters: params);
      final data = response.data as Map?;
      if (data != null) {
        final results = data['results'] as List? ?? [];
        if (results.isNotEmpty) {
          final formattedAddress = results[0]['formatted_address'] as String?;
          if (formattedAddress != null) {
            address = formattedAddress;
          }
        }
      }
      print('Response - ${response.data}');
      return address;
    } on DioError catch (error) {
      print('Error in getting address ${error.message}');
      throw const Failure(message: 'Error in getting address');
    } catch (error) {
      print('Error in getting address ${error.toString()}');
      throw const Failure(message: 'Error in getting address');
    }
  }

  Future<LatLng?> getPlaceDetails({required String placeId}) async {
    try {
      final params = {'placeid': placeId};
      final response =
          await Api.createDio().get(Urls.placeDetails, queryParameters: params);
      if (response.statusCode == 200 && response.data != null) {
        PlaceDetailsModel placeDetails =
            PlaceDetailsModel.fromJson(response.data);
        final lat = placeDetails.result?.geometry?.location?.lat;
        final lng = placeDetails.result?.geometry?.location?.lng;

        if (lat != null && lng != null) {
          return LatLng(lat, lng);
        }
      }
      return null;
    } on DioError catch (error) {
      print('Error in getting place details ${error.message}');
      throw const Failure(message: 'Error in getting place details s');
    } catch (error) {
      print('Error in getting place details  ${error.toString()}');
      throw const Failure(message: 'Error in getting place details ');
    }
  }

  Future<List<PredictionModel?>> searchLocation({required String text}) async {
    try {
      List<PredictionModel?> predictions = [];
      if (text.isNotEmpty) {
        final params = {
          'search_text': text,
        };
        final response = await Api.createDio()
            .get(Urls.searchLocation, queryParameters: params);
        if (response.statusCode == 200 && response.data != null) {
          final data = response.data['predictions'] as List? ?? [];
          for (var prediction in data) {
            predictions.add(PredictionModel.fromJson(prediction));
          }
        }
      }

      return predictions;
    } on DioError catch (error) {
      print('Error getting prediction ${error.message} ');
      throw const Failure(message: 'Error getting location');
    } catch (error) {
      print('Error getting prediction ${error.toString()} ');
      throw const Failure(message: 'Error getting location');
    }
  }

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
