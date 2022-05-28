import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/failure.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingState.initial());

  void changePage(int index) {
    emit(
        state.copyWith(selectedIndex: index, status: OnBoardingStatus.initial));
  }
}
