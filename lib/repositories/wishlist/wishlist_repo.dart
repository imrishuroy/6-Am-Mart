import 'package:dio/dio.dart';
import '/api/api.dart';
import '/config/urls.dart';
import '/repositories/wishlist/base_wishlist_repo.dart';

class WishListRepository extends BaseWishListRepo {
  Future<Response> getWishList() async {
    return await Api.createDio().get(Urls.wishListUri);
  }

  Future<Response?> addWishList(int? id, bool isStore) async {
    if (id == null) {
      return null;
    }

    print(
        'Urls --- ${Urls.addWishListUri}${isStore ? 'store_id=' : 'item_id='}$id');
    return await Api.createDio()
        .post('${Urls.addWishListUri}${isStore ? 'store_id=' : 'item_id='}$id');
  }

  Future<Response> removeWishList(int id, bool isStore) async {
    return await Api.createDio().delete(
        '{$Urls.removeWishListUri}${isStore ? 'store_id=' : 'item_id='}$id');
  }
}
