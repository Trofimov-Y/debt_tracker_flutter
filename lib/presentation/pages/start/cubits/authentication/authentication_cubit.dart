import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:debt_tracker/domain/entities/user_entity.dart';
import 'package:debt_tracker/domain/usecases/get_authentication_changes_usecase.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'authentication_cubit.freezed.dart';

part 'authentication_state.dart';

@lazySingleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
    this._getAuthenticationChangesUseCase,
    this._router,
  ) : super(const AuthenticationState.initial()) {
    _init();
  }

  final AppRouter _router;
  final GetAuthenticationChangesUseCase _getAuthenticationChangesUseCase;

  StreamSubscription<UserEntity?>? _authenticationChangesSubscription;

  void _init() {
    _authenticationChangesSubscription = _getAuthenticationChangesUseCase().listen((user) {
      log('Authentication (User) - $user');
      state.maybeMap(
        initial: (_) {
          if (user == null) {
            emit(const AuthenticationState.unauthenticated());
          } else {
            emit(AuthenticationState.authenticated(user: user));
          }
        },
        orElse: () {
          if (user == null) {
            emit(const AuthenticationState.unauthenticated());
            _router.replaceAll([const WelcomeRoute()], updateExistingRoutes: false);
          } else {
            emit(AuthenticationState.authenticated(user: user));
          }
        },
      );
    });
  }

  @override
  Future<void> close() async {
    _authenticationChangesSubscription?.cancel();
    _authenticationChangesSubscription = null;
    super.close();
  }
}
