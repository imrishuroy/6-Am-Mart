import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/models/store.dart';
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
}
