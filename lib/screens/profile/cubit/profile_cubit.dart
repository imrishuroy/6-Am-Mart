import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:six_am_mart/models/failure.dart';
import 'package:six_am_mart/models/user.dart';

import '/repositories/user/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;
  ProfileCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileState.initial());

  void loaduserProfile() async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));

      final user = await _userRepository.getUserDetails();
      if (user != null) {
        emit(state.copyWith(user: user, status: ProfileStatus.succuss));
      } else {
        emit(state.copyWith(
            failure: const Failure(message: 'Proifile not found'),
            status: ProfileStatus.error));
      }
    } on Failure catch (_) {
      rethrow;
    }
  }
}
