import 'package:dio/dio.dart';
import 'package:six_am_mart/models/category.dart';
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
        'zoneID': '1',
        'moduleID': '1',
      };

      final response =
          await _dio.get(Urls.banner, options: Options(headers: headers));

      if (response.statusCode == 200) {
        final responseData = response.data;
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