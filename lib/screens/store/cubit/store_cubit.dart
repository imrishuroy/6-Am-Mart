import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/category.dart';
import '/models/item.dart';
import '/models/store.dart';
import '/models/banner.dart';
import '/models/failure.dart';
import '/repositories/store/store_repository.dart';
part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository _storeRepository;
  final String _moduleId;
  StoreCubit({
    required StoreRepository storeRepository,
    required String moduleId,
  })  : _storeRepository = storeRepository,
        _moduleId = moduleId,
        super(StoreState.initial());

  void loadStore() async {
    try {
      emit(state.copyWith(status: StoreStatus.loading));
      final banners =
          await _storeRepository.getStoreBanners(moduleId: _moduleId);

      final allStores =
          await _storeRepository.getAllStores(moduleId: _moduleId);

      print('All Stores --- $allStores');

      final popularStores =
          await _storeRepository.getPopularStores(moduleId: _moduleId);

      print('Popular Stores -- $popularStores');

      emit(
        state.copyWith(
          banners: banners,
          allStores: allStores,
          popularStores: popularStores,
          status: StoreStatus.succuss,
        ),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: StoreStatus.error));
    }
  }

  void loadCategories({required int? storeId}) async {
    try {
      emit(state.copyWith(status: StoreStatus.loading));

      final categories = await _storeRepository.getCategories(storeId: storeId);
      emit(state.copyWith(categories: categories, status: StoreStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: StoreStatus.error));
    }
  }

  void loadCategoryItems({
    required String moduleId,
    required int? storeId,
    required int? categoryId,
  }) async {
    if (storeId == null || categoryId == null) {
      return;
    }
    try {
      final items = await _storeRepository.getStoreItems(
        moduleId: moduleId,
        storeId: storeId,
        categoryId: categoryId,
      );

      print('Items -- $items');

      emit(state.copyWith(items: items, status: StoreStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: StoreStatus.error));
    }
  }
}
