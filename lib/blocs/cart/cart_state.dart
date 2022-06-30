part of 'cart_cubit.dart';

enum CartStatus { initial, loading, succuss, error }

class CartState extends Equatable {
  final List<CartModel?> cartList;
  final CartStatus status;
  final Failure failure;

  const CartState({
    required this.cartList,
    required this.status,
    required this.failure,
  });

  factory CartState.initial() => const CartState(
        cartList: [],
        status: CartStatus.initial,
        failure: Failure(),
      );

  @override
  List<Object> get props => [cartList, status, failure];

  CartState copyWith({
    List<CartModel?>? cartList,
    CartStatus? status,
    Failure? failure,
  }) {
    return CartState(
      cartList: cartList ?? this.cartList,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  bool get stringify => true;
}
