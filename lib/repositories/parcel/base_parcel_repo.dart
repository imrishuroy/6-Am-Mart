import '/models/parcel_category_model.dart';

abstract class BaseParcelRepository {
  Future<List<ParcelCategoryModel?>> getParcelCategory();
}
