import 'package:dio/dio.dart';
import 'package:six_am_mart/models/store.dart';
import '/config/urls.dart';
import '/models/banner.dart';
import '/models/failure.dart';
import '/repositories/store/base_store_repo.dart';

class StoreRepository extends BaseStoreRepositoy {
  final Dio _dio;

  StoreRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<AppBanner?>> getStoreBanners({required String moduleId}) async {
    try {
      List<AppBanner?> banners = [];
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneID': '[1]',
        'moduleID': moduleId,
        //'X-localization': 'en'
      };

      final response =
          await _dio.get(Urls.banner, options: Options(headers: headers));

      print('Banner response data -- ${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        print('Banner response data -- $responseData');
        if (responseData != null) {
          final bannersData = responseData['banners'] as List? ?? [];

          for (var element in bannersData) {
            banners.add(AppBanner.fromMap(element));
          }
        }
      }
      return banners;
    } on DioError catch (error) {
      print('Error in getting banners ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error in getting store banner ');
      throw Failure(message: error.toString());
    }
  }

  Future<List<Store?>> getAllStores({required String moduleId}) async {
    try {
      List<Store?> stores = [];
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneID': '[1]',
        'moduleID': moduleId,
        //'X-localization': 'en'
      };

      final response =
          await _dio.get(Urls.allStore, options: Options(headers: headers));

      print('Store response data -- ${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        print('Store response data -- $responseData');
        if (responseData != null) {
          final storesList = responseData['stores'] as List? ?? [];

          print('Stores list $storesList');

          for (var element in storesList) {
            stores.add(Store.fromMap(element));
          }
        }
      }
      return stores;
    } on DioError catch (error) {
      print('Error in getting all stores ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error in getting all states ${error.toString()}');
      throw Failure(message: error.toString());
    }
  }

  Future<List<Store?>> getPopularStores({required String moduleId}) async {
    try {
      List<Store?> stores = [];
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneID': '[1]',
        'moduleID': moduleId,
        //'X-localization': 'en'
      };

      final parameter = {'offset': 1, 'limit': 10};

      final response = await _dio.get(
        Urls.popularStore,
        queryParameters: parameter,
        options: Options(
          headers: headers,
        ),
      );

      print('Popular stores response data -- ${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        print('Popular stores response data -- $responseData');
        if (responseData != null) {
          final storesList = responseData as List? ?? [];

          for (var element in storesList) {
            stores.add(Store.fromMap(element));
          }
        }
      }
      return stores;
    } on DioError catch (error) {
      print('Error in getting popular stores ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error in getting store popular stores ');
      throw Failure(message: error.toString());
    }
  }
}
