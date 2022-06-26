import 'package:dio/dio.dart';
import 'package:six_am_mart/models/category.dart';
import 'package:six_am_mart/models/module.dart';
import 'package:six_am_mart/models/store.dart';
import '/config/urls.dart';
import '/models/banner.dart';
import '/models/failure.dart';
import '/repositories/dashboard/base_dashboard_repo.dart';

class DashBoardRepository extends BaseDashBoardRepo {
  final _dio = Dio();

  Future<List<AppBanner?>> getBanners() async {
    try {
      List<AppBanner?> banners = [];
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneID': '[1]',
        //'moduleID': '0',
        //'X-localization': 'en'
      };

      final response =
          // await _dio.get(
          //     'https://6ammart-admin.6amtech.com/api/v1/banners',
          //     options: Options(headers: headers));
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
      print('Error in getting banners ${error.toString()}');
      throw const Failure(message: 'Error getting banners');
    }
  }

  Future<List<Module?>> getModules() async {
    try {
      List<Module?> modules = [];

      final response = await _dio.get(Urls.module);
      if (response.statusCode == 200) {
        final data = response.data as List? ?? [];

        for (var element in data) {
          modules.add(Module.fromMap(element));
        }
      }
      return modules;
    } on DioError catch (error) {
      print('Error in getting modules ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error getting modules ${error.toString()}');
      throw const Failure(message: 'Error getting modules');
    }
  }

  Future<List<Store?>> getFeaturedStores() async {
    try {
      List<Store?> featuredStores = [];
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneID': '[1]',
        //'moduleID': '0',
      };

      final response = await _dio.get(Urls.featuredStores,
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final responseData = response.data as Map?;
        if (responseData != null) {
          final stores = response.data['stores'] as List? ?? [];
          for (var element in stores) {
            featuredStores.add(Store.fromMap(element));
          }
        }
      }
      return featuredStores;
    } on DioError catch (error) {
      print('Error in getting featured stores ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error in getting featured stores ${error.toString()}');
      throw const Failure(message: 'Error getting featured stores');
    }
  }

  Future<List<AppCategory?>> getCategories() async {
    try {
      List<AppCategory?> categories = [];
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneID': '1',
        'moduleID': '1',
      };

      final response =
          await _dio.get(Urls.catagory, options: Options(headers: headers));

      if (response.statusCode == 200) {
        final responseData = response.data as List? ?? [];

        for (var element in responseData) {
          categories.add(AppCategory.fromMap(element));
        }
      }
      return categories;
    } on DioError catch (error) {
      print('Error in getting banners ${error.message}');
      throw Failure(message: error.message);
    } catch (error) {
      print('Error in getting banners ${error.toString()}');
      throw const Failure(message: 'Error getting categories');
    }
  }
}
