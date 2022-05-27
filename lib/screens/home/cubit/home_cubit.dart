import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/models/module.dart';
import '/models/category.dart';
import '/models/banner.dart';
import '/models/failure.dart';
import '/repositories/dashboard/dashboard_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DashBoardRepository _dashBoardRepository;
  HomeCubit({required DashBoardRepository dashBoardRepository})
      : _dashBoardRepository = dashBoardRepository,
        super(HomeState.initial());

  void load() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final banners = await _dashBoardRepository.getBanners();
      final modules = await _dashBoardRepository.getModules();
      // final categories = await _dashBoardRepository.getCategories();

      emit(
        state.copyWith(
          status: HomeStatus.succuss,
          banners: banners,
          modules: modules,
          categories: [],
        ),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: HomeStatus.error));
    }
  }
}
