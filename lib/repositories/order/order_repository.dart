import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/api/api.dart';
import '/config/urls.dart';
import '/models/place_order_body.dart';

class OrderRepository {
  Future<Response> getRunningOrderList(int offset) async {
    return await Api.createDio()
        .get('${Urls.runningOrderList}?offset=$offset&limit=10');
  }

  Future<Response> getHistoryOrderList(int offset) async {
    return await Api.createDio()
        .get('${Urls.historyOrderList}?offset=$offset&limit=10');
  }

  Future<Response> getOrderDetails(String orderID) async {
    return await Api.createDio().get('${Urls.orderDetailsUrl}$orderID');
  }

  Future<Response> cancelOrder(String orderID) async {
    return await Api.createDio().post(Urls.orderCancelUrl,
        data: {'_method': 'put', 'order_id': orderID});
  }

  Future<Response> trackOrder(String orderID) async {
    return await Api.createDio().get('${Urls.trackUri}$orderID');
  }

  Future<Response> placeOrder(
      PlaceOrderBody orderBody, XFile orderAttachment) async {
    //dio.options.headers["Content-Type"] = "multipart/form-data";

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        orderAttachment.path,
        filename: orderAttachment.name,
      )
    });

    return await Api.createDio().post(Urls.placeOrderUri,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));
  }

  Future<Response> getDeliveryManData(String orderID) async {
    return await Api.createDio().get('${Urls.lastLocationUri}$orderID');
  }

  Future<Response> switchToCOD(String orderID) async {
    return await Api.createDio()
        .post(Urls.codSwitchUri, data: {'_method': 'put', 'order_id': orderID});
  }

  Future<Response> getDistanceInMeter(
      LatLng originLatLng, LatLng destinationLatLng) async {
    return await Api.createDio().get(
        '${Urls.distanceMatrixUri}?origin_lat=${originLatLng.latitude}&origin_lng=${originLatLng.longitude}'
        '&destination_lat=${destinationLatLng.latitude}&destination_lng=${destinationLatLng.longitude}');
  }
}
