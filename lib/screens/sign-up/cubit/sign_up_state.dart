part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, submitting, succuss, error }

class SignUpState extends Equatable {
  final String? fName;
  final String? lName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final SignUpStatus status;
  final Failure failure;
  final bool showPassword;
  const SignUpState({
    this.fName,
    this.lName,
    this.email,
    this.phoneNumber,
    this.password,
    required this.status,
    required this.failure,
    required this.showPassword,
  });

  SignUpState copyWith({
    String? fName,
    String? lName,
    String? email,
    String? phoneNumber,
    String? password,
    SignUpStatus? status,
    Failure? failure,
    bool? showPassword,
  }) {
    return SignUpState(
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      showPassword: showPassword ?? this.showPassword,
    );
  }

//   bool get isFormValid => phoneNumber.isNotEmpty && password.isNotEmpty;

  factory SignUpState.initial() => const SignUpState(
      status: SignUpStatus.initial, failure: Failure(), showPassword: false);

  @override
  String toString() {
    return 'SignUpState(fName: $fName, lName: $lName, email: $email, phoneNumber: $phoneNumber, password: $password, status: $status, failure: $failure, showPassword: $showPassword)';
  }

  @override
  List<Object?> get props {
    return [
      fName,
      lName,
      email,
      phoneNumber,
      password,
      status,
      failure,
      showPassword,
    ];
  }
}
