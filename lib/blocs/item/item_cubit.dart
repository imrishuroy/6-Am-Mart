import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/api/api_checker.dart';
import 'package:six_am_mart/models/failure.dart';
import 'package:six_am_mart/models/item.dart';
import 'package:six_am_mart/models/item_model.dart';
import 'package:six_am_mart/repositories/item/item_repository.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final ItemRepository _itemRepository;
  ItemCubit({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(ItemState.initial());

  Future<void> getPopularItemList(bool reload, String type, bool notify,
      {required BuildContext context}) async {
    emit(state.copyWith(popularType: type));

    if (reload) {
      emit(state.copyWith(popularItemList: []));
      // _popularItemList = null;
    }
    if (notify) {
      // update();
    }
    if (state.popularItemList.isEmpty || reload) {
      Response response = await _itemRepository.getPopularItemList(type);

      if (response.statusCode == 200) {
        emit(state.copyWith(popularItemList: []));
        final data = response.data as Map<String, dynamic>? ?? {};

        emit(state.copyWith(
            popularItemList: state.popularItemList
              ..addAll(ItemModel.fromMap(data).items),
            isLoading: false));
      } else {
        ApiChecker.checkApi(response, context: context);
      }
      // update();
    }
  }
}
