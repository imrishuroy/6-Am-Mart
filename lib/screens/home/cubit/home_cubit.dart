import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:six_am_mart/blocs/wishlist/wishlist_cubit.dart';
import '/models/app_module.dart';
import '/models/store.dart';
import '/models/category.dart';
import '/models/banner.dart';
import '/models/failure.dart';
import '/repositories/dashboard/dashboard_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DashBoardRepository _dashBoardRepository;
  final WishlistCubit _wishlistCubit;
  HomeCubit({
    required DashBoardRepository dashBoardRepository,
    required WishlistCubit wishlistCubit,
  })  : _dashBoardRepository = dashBoardRepository,
        _wishlistCubit = wishlistCubit,
        super(HomeState.initial());

  void load() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final banners = await _dashBoardRepository.getBanners();
      final modules = await _dashBoardRepository.getModules();
      final stores = await _dashBoardRepository.getFeaturedStores();
      await _wishlistCubit.getWishList();
      // final categories = await _dashBoardRepository.getCategories();

      emit(
        state.copyWith(
          status: HomeStatus.succuss,
          banners: banners,
          modules: modules,
          featuredStores: stores,
          categories: [],
        ),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: HomeStatus.error));
    }
  }
}
