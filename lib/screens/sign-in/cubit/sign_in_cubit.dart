import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/failure.dart';
import '/repositories/auth/auth_repo.dart';

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
      final result = await _authRepository.loginUser(
        phoneNumber: state.phoneNumber,
        password: state.password,
      );
      if (result) {
        emit(state.copyWith(status: SignInStatus.succuss));
      } else {
        emit(
          state.copyWith(
            status: SignInStatus.error,
            failure: const Failure(message: 'Error login, please try again'),
          ),
        );
      }
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SignInStatus.error));
    }
  }
}
