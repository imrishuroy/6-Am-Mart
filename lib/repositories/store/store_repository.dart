import 'package:dio/dio.dart';
import '/models/category.dart';
import '/models/store_details.dart';
import '/models/item.dart';
import '/models/store.dart';
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

  Future<List<Item?>> getStoreItems({
    required String moduleId,
    required int? storeId,
    required int? categoryId,
  }) async {
    try {
      if (storeId == null || categoryId == null) {
        return [];
      }
      List<Item?> items = [];
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneID': '[1]',
        'moduleID': moduleId,
        //'X-localization': 'en'
      };

      final parameter = {
        'store_id': storeId,
        'category_id': categoryId,
        'offset': 1,
        'limit': 10,
        'type': 'all'
      };

      print('Store id -- $storeId, Category Id -- $categoryId');

      final response = await _dio.get(
        Urls.storeItem,
        queryParameters: parameter,
        options: Options(
          headers: headers,
        ),
      );

      print('Store Items response data -- ${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        print('Store Items response data -- $responseData');
        if (responseData != null) {
          final itemsList = responseData['products'] as List? ?? [];

          print('Item list - $itemsList');

          for (var element in itemsList) {
            items.add(Item.fromMap(element));
          }
        }
      }
      return items;
    } on DioError catch (error) {
      print('Error in getting store items ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error in getting store items');
      throw Failure(message: error.toString());
    }
  }

  Future<StoreDetails?> getStoreDetails({
    required int? storeId,
  }) async {
    try {
      if (storeId == null) {
        return null;
      }
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneID': '[1]',
        'moduleID': '1',
        //'X-localization': 'en'
      };

      final response = await _dio.get('${Urls.storeDetails}$storeId',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>?;
        if (responseData != null) {
          return StoreDetails.fromMap(responseData);
        }
      }
      return null;
    } on DioError catch (error) {
      print('Error in getting categories ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error in getting store details ${error.toString()}');
      throw Failure(message: error.toString());
    }
  }

  Future<List<AppCategory?>> getCategories({required int? storeId}) async {
    try {
      if (storeId == null) {
        return [];
      }
      final List<AppCategory?> categories = [];
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneID': '[1]',
        'moduleID': '1',
        //'X-localization': 'en'
      };

      final storeDetails = await getStoreDetails(storeId: storeId);

      final response =
          await _dio.get(Urls.catagory, options: Options(headers: headers));

      print('Category data -- ${response.data}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        print('Category data 2 -- $responseData');
        if (responseData != null) {
          final categoriesList = responseData as List? ?? [];

          for (var element in categoriesList) {
            categories.add(AppCategory.fromMap(element));
          }
        }
      }

      // categories.sort((a, b) => a!.id!.compareTo(b!.id!));

      // return categories
      //   ..removeWhere((element) =>
      //       !(storeDetails?.categoryIds.contains(element?.id) ?? true))
      //   ..sort((a, b) => b!.id!.compareTo(a!.id!));

      return categories
        ..removeWhere((element) =>
            !(storeDetails?.categoryIds.contains(element?.id) ?? true))
        ..sort((a, b) {
          if (a?.id != null && b?.id != null) {
            return b!.id!.compareTo(a!.id!);
          }
          return 0;
        });
    } on DioError catch (error) {
      print('Error in getting categories ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error in getting categories');
      throw Failure(message: error.toString());
    }
  }
}
