part of 'user_cubit.dart';

enum UserStatus { initial, loading, succuss, error }

class UserState extends Equatable {
  final User? user;
  final XFile? pickedFile;
  final Uint8List? rawFile;
  final bool isLoading;
  final UserStatus status;
  final Failure failure;

  const UserState({
    this.user,
    this.pickedFile,
    this.rawFile,
    required this.isLoading,
    required this.status,
    required this.failure,
  });

  factory UserState.initial() => const UserState(
        isLoading: false,
        status: UserStatus.initial,
        failure: Failure(),
      );

  UserState copyWith({
    User? user,
    XFile? pickedFile,
    Uint8List? rawFile,
    bool? isLoading,
    UserStatus? status,
    Failure? failure,
  }) {
    return UserState(
      user: user ?? this.user,
      pickedFile: pickedFile ?? this.pickedFile,
      rawFile: rawFile ?? this.rawFile,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props {
    return [
      user,
      pickedFile,
      rawFile,
      isLoading,
      status,
      failure,
    ];
  }
}
