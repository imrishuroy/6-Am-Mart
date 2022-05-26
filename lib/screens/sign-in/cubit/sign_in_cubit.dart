import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/models/failure.dart';
import 'package:six_am_mart/repositories/auth/auth_repo.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;

  SignInCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignInState.initial());

  void phoneNumberChanged(String value) {
    emit(state.copyWith(phoneNumber: value, status: SignInStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignInStatus.initial));
  }

  void showPassword(bool showPassword) {
    emit(state.copyWith(
        showPassword: !showPassword, status: SignInStatus.initial));
  }

  void signInWithPhoneNo() async {
    emit(state.copyWith(status: SignInStatus.submitting));
    try {
      await _authRepository.loginUser(
        phoneNumber: state.phoneNumber,
        password: state.password,
      );
      emit(state.copyWith(status: SignInStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(failure: error, status: SignInStatus.error));
    }
  }
}
