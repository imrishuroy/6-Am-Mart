part of 'sign_in_cubit.dart';

enum SignInStatus { initial, submitting, succuss, error }

class SignInState extends Equatable {
  final String phoneNumber;
  final String password;

  final SignInStatus status;

  final Failure failure;
  final bool showPassword;

  const SignInState({
    required this.phoneNumber,
    required this.password,
    required this.status,
    required this.failure,
    required this.showPassword,
  });

  bool get isFormValid => phoneNumber.isNotEmpty && password.isNotEmpty;

  factory SignInState.initial() {
    return const SignInState(
      phoneNumber: '',
      password: '',
      status: SignInStatus.initial,
      failure: Failure(),
      showPassword: false,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [phoneNumber, password, status, failure, showPassword];

  SignInState copyWith({
    String? phoneNumber,
    String? password,
    SignInStatus? status,
    Failure? failure,
    bool? showPassword,
  }) {
    return SignInState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}
