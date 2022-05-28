import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/failure.dart';
import '/repositories/auth/auth_repo.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignUpState.initial());

  void fNameChanged(String value) {
    emit(state.copyWith(fName: value, status: SignUpStatus.initial));
  }

  void lNameChanged(String value) {
    emit(state.copyWith(lName: value, status: SignUpStatus.initial));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignUpStatus.initial));
  }

  void showPassword(bool showPassword) {
    emit(state.copyWith(
        showPassword: !showPassword, status: SignUpStatus.initial));
  }

  void phoneChanged(String value) {
    emit(state.copyWith(phoneNumber: value, status: SignUpStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignUpStatus.initial));
  }

  void signUp() async {
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      await _authRepository.singUpUser(
        phoneNumber: state.phoneNumber,
        password: state.password,
        email: '',
        fName: '',
        lName: '',
        phone: '',
      );
      emit(state.copyWith(status: SignUpStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(failure: error, status: SignUpStatus.error));
    }
  }
}
