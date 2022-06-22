part of 'profile_cubit.dart';

enum ProfileStatus { initial, succuss, error, loading }

class ProfileState extends Equatable {
  final User? user;
  final Failure failure;
  final ProfileStatus status;

  const ProfileState({
    required this.user,
    required this.failure,
    required this.status,
  });

  factory ProfileState.initial() => const ProfileState(
      user: null, failure: Failure(), status: ProfileStatus.initial);

  ProfileState copyWith({
    User? user,
    Failure? failure,
    ProfileStatus? status,
  }) {
    return ProfileState(
      user: user ?? this.user,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [user, failure, status];

  @override
  String toString() =>
      'ProfileState(user: $user, failure: $failure, status: $status)';
}
