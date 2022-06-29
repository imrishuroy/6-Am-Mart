part of 'wishlist_cubit.dart';

enum WishListStatus { initial, loading, succuss, error }

class WishListState extends Equatable {
  final List<Item?> wishItemList;
  final List<Store?> wishStoreList;
  final List<int> wishItemIdList;
  final List<int> wishStoreIdList;

  const WishListState({
    required this.wishItemList,
    required this.wishStoreList,
    required this.wishItemIdList,
    required this.wishStoreIdList,
  });

  factory WishListState.initial() => const WishListState(
        wishItemList: [],
        wishStoreList: [],
        wishItemIdList: [],
        wishStoreIdList: [],
      );

  @override
  List<Object> get props =>
      [wishItemList, wishStoreList, wishItemIdList, wishStoreIdList];

  WishListState copyWith({
    List<Item?>? wishItemList,
    List<Store?>? wishStoreList,
    List<int>? wishItemIdList,
    List<int>? wishStoreIdList,
  }) {
    return WishListState(
      wishItemList: wishItemList ?? this.wishItemList,
      wishStoreList: wishStoreList ?? this.wishStoreList,
      wishItemIdList: wishItemIdList ?? this.wishItemIdList,
      wishStoreIdList: wishStoreIdList ?? this.wishStoreIdList,
    );
  }

  @override
  bool get stringify => true;
}
