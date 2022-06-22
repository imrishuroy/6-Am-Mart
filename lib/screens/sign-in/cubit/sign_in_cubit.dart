import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/repositories/user/user_repository.dart';
import '/repositories/auth/auth_repository.dart';
import '/models/failure.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SignInCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
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
      final token = await _authRepository.loginUser(
        phoneNumber: state.phoneNumber,
        password: state.password,
      );
      if (token != null) {
        final user = await _userRepository.getUserDetails();

        if (user != null) {
          emit(state.copyWith(status: SignInStatus.succuss));
        } else {
          emit(
            state.copyWith(
              status: SignInStatus.error,
              failure: const Failure(message: 'Error login, please try again'),
            ),
          );
        }
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
