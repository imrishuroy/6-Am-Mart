import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/cart_model.dart';
import '/models/failure.dart';
import '/repositories/cart/cart_repositroy.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepo;
  CartCubit({required CartRepository cartRepository})
      : _cartRepo = cartRepository,
        super(CartState.initial());

  void getCartData() {
    emit(state.copyWith(status: CartStatus.loading));
    final cartList = _cartRepo.getCartList();
    emit(state.copyWith(cartList: cartList, status: CartStatus.succuss));
  }

  void addToCart(CartModel cartModel, int? index) {
    if (index != null && index != -1) {
      emit(state.copyWith(
          cartList: state.cartList
            ..replaceRange(index, index + 1, [cartModel])));
    } else {
      emit(state.copyWith(cartList: List.from(state.cartList)..add(cartModel)));
    }
    // TODO: check setExistInCart
    // Get.find<ItemController>().setExistInCart(cartModel.item, notify: true);
    _cartRepo.addToCartList(state.cartList);
    //update();
  }
}
