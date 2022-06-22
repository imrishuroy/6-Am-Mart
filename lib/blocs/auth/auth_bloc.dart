import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/failure.dart';
import '/repositories/auth/auth_repository.dart';
import '/enums/enums.dart';
import '/models/user.dart';
import '/repositories/user/user_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(AuthState.unknown()) {
    //final user = await _userRepository.getUserDetails();

    // _authSubscription = _authRepository.status
    //     .listen((status) => add(AuthStatusChanged(status)));
    on<AuthStatusChanged>((event, emit) async {
      try {
        final user = await _userRepository.getUserDetails();
        print('User auth bloc $user');
        if (user != null) {
          emit(AuthState.authenticated(user));
        } else {
          emit(AuthState.unauthenticated());
        }
      } on Failure catch (_) {
        emit(AuthState.unauthenticated());
      }

      // switch (event.status) {
      //   case AuthenticationStatus.unauthenticated:
      //     emit(AuthState.unauthenticated());
      //     break;

      //   case AuthenticationStatus.authenticated:
      //     final user = await _userRepository.getUserDetails();
      //     print('User $user');
      //     //    final _prefs =awa SharedPreferences.getInstance();

      //     emit(user == null
      //         ? AuthState.authenticated(user)
      //         : AuthState.unauthenticated());

      //     // emit(user
      //     //     ? AuthState.authenticated(null)
      //     //     : AuthState.unauthenticated());
      //     break;

      //   default:
      //     return emit(AuthState.unknown());
      // }
    });
    on<AuthLogoutRequested>((event, emit) {});
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  late StreamSubscription<AuthenticationStatus>? _authSubscription;

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    // _authRepository.dispose();
    return super.close();
  }

  // Future<User?> _tryGetUser() async {
  // Future<> _tryGetUser() async {
  //   try {
  //     final result = await _userRepository.getUserDetails();
  //     return result;
  //   } on Exception {
  //     return false;
  //   }
  // }
}
