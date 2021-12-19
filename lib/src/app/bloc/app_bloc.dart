import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<User> _userSubscription;

  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogOutRequested>(_onLogOutRequested);
    _userSubscription = _authenticationRepository.user.listen((user) {
      print("user changed");
      add(AppUserChanged(user));
    });
  }

  FutureOr<void> _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    print("Login requested");
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  FutureOr<void> _onLogOutRequested(
      AppLogOutRequested event, Emitter<AppState> emit) {
    print("Log out requested");
    unawaited(_authenticationRepository.logOut());
  }
}
