import 'package:dio/dio.dart';
import '/api/api.dart';
import '/config/urls.dart';
import '/models/review_body.dart';
import '/repositories/item/base_item_repo.dart';

class ItemRepository extends BaseItemRepository {
  Future<Response> getPopularItemList(String type) async {
    return await Api.createDio().get('${Urls.popularItemUri}?type=$type');
  }

  Future<Response> getReviewedItemList(String type) async {
    return await Api.createDio().get('${Urls.reviewedItemUrl}?type=$type');
  }

  Future<Response> submitReview(ReviewBody reviewBody) async {
    final body = reviewBody.toMap();
    return await Api.createDio().post(
      Urls.reviewUrl,
      data: body,
    );
  }

  Future<Response> submitDeliveryManReview(ReviewBody reviewBody) async {
    final body = reviewBody.toMap();
    return await Api.createDio().post(
      Urls.deliverManReviewUri,
      data: body,
    );
  }

  Future<Response> getItemDetails(int itemID) async {
    return Api.createDio().get('${Urls.itemDetailsUri}$itemID');
  }
}
