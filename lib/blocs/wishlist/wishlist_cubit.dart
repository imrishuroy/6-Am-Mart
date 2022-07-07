import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/item.dart';
import '/models/store.dart';
import '/repositories/wishlist/wishlist_repo.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishListState> {
  final WishListRepository _wishListRepo;
  // final ItemRepository _itemRepository;
  WishlistCubit({
    required WishListRepository wishListRepo,
    // required ItemRepository itemRepository,
  })  : _wishListRepo = wishListRepo,
        // _itemRepository = itemRepository,
        super(WishListState.initial());

  // item bottom sheet
  // wishList.addToWishList(widget.item, null, false);

  // from item page
  // wishController.addToWishList(item, store,

  // from store page
  // wishController.addToWishList(null, _storeList[index], true);

  // wishController.addToWishList(null, store, true);
  // from store widget

  //  wishController.addToWishList(null, _storeList[index], true);

// details web view.dart
  //wishController.addToWishList(itemController.item, null, false);

  // wishController.addToWishList(item, null, false);

// store description
  //wishController.addToWishList(null, store, true);

  void addToWishList(Item? product, Store? store, bool isStore) async {
    print('Item in wishlist 3-- $product');
    if (isStore) {
      print('Item in wishlist 4');
      if (store?.id == null) {
        print('Item in wishlist 5');
        return;
      }
    } else {
      print('Item in wishlist 6');
      if (product?.id == null) {
        print('Item in wishlist 7');
        return;
      }
    }

    print('Add to wishlist called --- $product');
    print('Wishlist 22-- $isStore $product $store');
    print('Wishlist 22 -- $store');
    print('Wishlist 22 aaaa-- ${isStore ? store!.id! : product!.id}');
    print('Wishlist 22 -- product id ${product?.id}');
    Response? response = await _wishListRepo.addWishList(
        isStore ? store!.id! : product!.id, isStore);

    print('Response in wishlist daaa-- ${response?.data}');
    print('Response in wishlist-- ${response?.statusCode}');

    if (response?.statusCode == 200) {
      if (isStore) {
        print('Item in wishlist 8');
        emit(
          state.copyWith(
            wishStoreIdList: List.from(state.wishStoreIdList)..add(store!.id!),
            wishStoreList: List.from(state.wishStoreList)..add(store),
          ),
        );
        // _wishStoreIdList.add(store.id);
        // _wishStoreList.add(store);
      } else {
        print('Item in wishlist 2-- $product');
        emit(
          state.copyWith(
            wishItemList: List.from(state.wishItemList)..add(product),
            wishItemIdList: List.from(state.wishItemIdList)..add(product!.id),
          ),
        );

        // _wishItemList.add(product);
        // _wishItemIdList.add(product.id);
      }
      // TODO: add snakbar for succussfull item add to wishlist
      //showCustomSnackBar(response.body['message'], isError: false);
    } else {
      // ApiChecker.checkApi(response);
    }
    // update();
  }

  void removeFromWishList(int id, bool isStore) async {
    Response response = await _wishListRepo.removeWishList(id, isStore);
    if (response.statusCode == 200) {
      int idIndex = -1;
      if (isStore) {
        idIndex = state.wishStoreIdList.indexOf(id);
        emit(
          state.copyWith(
            wishStoreIdList: state.wishStoreIdList..removeAt(idIndex),
            wishStoreList: state.wishStoreList..removeAt(idIndex),
          ),
        );
        // _wishStoreIdList.removeAt(idIndex);
        // _wishStoreList.removeAt(idIndex);
      } else {
        idIndex = state.wishItemIdList.indexOf(id);
        emit(
          state.copyWith(
            wishItemIdList: state.wishItemIdList..removeAt(idIndex),
            wishItemList: state.wishItemList..removeAt(idIndex),
          ),
        );
        // _wishItemIdList.removeAt(idIndex);
        // _wishItemList.removeAt(idIndex);
      }
      //showCustomSnackBar(response.body['message'], isError: false);
    } else {
      //ApiChecker.checkApi(response);
    }
    //  update();
  }

  Future<void> getWishList() async {
    // _wishItemList = [];
    // _wishStoreList = [];
    // _wishStoreIdList = [];

    final List<Item?> wishItemList = [];
    final List<Store?> wishStoreList = [];
    final List<int> wishItemIdList = [];
    final List<int> wishStoreIdList = [];

    Response response = await _wishListRepo.getWishList();
    print('Wishlis item -- ${response.data}');
    if (response.statusCode == 200) {
      final items = response.data['item'] as List? ?? [];
      for (var element in items) {
        Item item = Item.fromMap(element);
        wishItemList.add(item);
        wishItemIdList.add(item.id);
      }

      print('Wishlist item -- qqq $wishItemList');

      emit(
        state.copyWith(
          wishItemList: wishItemList,
          wishItemIdList: wishItemIdList,
        ),
      );

      final store = response.data['store'] as List? ?? [];

      for (var element in store) {
        Store store = Store.fromMap(element);
        wishStoreList.add(store);
        wishStoreIdList.add(store.id!);
      }
    } else {
      // ApiChecker.checkApi(response);
    }
    //update();
  }

  void removeWishes() {
    emit(state.copyWith(
      wishItemIdList: [],
      wishStoreIdList: [],
    ));
  }
}
