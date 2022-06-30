import 'dart:convert';
import '/config/shared_prefs.dart';
import '/constants/app_constants.dart';
import '/models/cart_model.dart';
import '/repositories/cart/base_cart_repo.dart';

class CartRepository extends BaseCartRepository {
  List<CartModel> getCartList() {
    List<String> carts = [];
    if (SharedPrefs().containsKey(AppConstants.cartList)) {
      carts = SharedPrefs().getCartList(AppConstants.cartList);
    }
    List<CartModel> cartList = [];
    for (var cart in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(cart)));
    }
    return cartList;
  }

  void addToCartList(List<CartModel?> cartProductList) {
    List<String> carts = [];
    for (var cartModel in cartProductList) {
      carts.add(jsonEncode(cartModel));
    }
    SharedPrefs().setCartList(value: AppConstants.cartList, cart: carts);
  }
}
