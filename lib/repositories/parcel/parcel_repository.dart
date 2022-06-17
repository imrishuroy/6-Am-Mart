import 'package:dio/dio.dart';
import 'package:six_am_mart/api/api.dart';
import 'package:six_am_mart/config/urls.dart';
import 'package:six_am_mart/models/failure.dart';
import 'package:six_am_mart/models/parcel_category_model.dart';

import 'base_parcel_repo.dart';

class ParcelRepository extends BaseParcelRepository {
  @override
  Future<List<ParcelCategoryModel?>> getParcelCategory() async {
    try {
      List<ParcelCategoryModel?> categories = [];
      final headers = {'moduleId': 5};
      final response = await Api.createDio()
          .get(Urls.parcelCategories, options: Options(headers: headers));
      print('Parcel categories -- ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as List? ?? [];

        for (var element in data) {
          categories.add(ParcelCategoryModel.fromMap(element));
        }
      }

      return categories;
    } on DioError catch (error) {
      print('Error getting parcel categories ${error.message}');
      throw const Failure(message: 'Error in getting parcel categories');
    } catch (error) {
      print('Error getting parcel categories ${error.toString()}');
      throw const Failure(message: 'Error in getting parcel categories');
    }
  }
}
