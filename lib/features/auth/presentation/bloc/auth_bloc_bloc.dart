import 'package:bloc/bloc.dart';
import 'package:ca_blog_app/core/cubits/cubit/app_user_cubit.dart';
import 'package:ca_blog_app/core/usecase/usecase.dart';
import 'package:ca_blog_app/core/common/entities/user.dart';
import 'package:ca_blog_app/features/auth/domain/usecases/auth_login.dart';
import 'package:ca_blog_app/features/auth/domain/usecases/auth_signup.dart';
import 'package:ca_blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter/material.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBlocBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthBlocInitial()) {
    on<AuthSignUp>(_onSignUp);
    on<AuthLogin>(_onLogin);
    on<AuthGetCurrentUser>(_onGetCurrentUser);
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState());

    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState());

    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  Future<void> _onGetCurrentUser(
    AuthGetCurrentUser event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthLoadingState());

    final res = await _currentUser(NoParams());

    print('Result: $res');

    res.fold(
      (failure) {
        emit(AuthFailureState(failure.message));
        print('Failure: ${failure.message}');
      },
      (user) {
        print('Current User: ${user.email}');
        _emitAuthSuccess(user, emit);
      },
    );
  }

  //to update app user cubit and emit success state
  //to get user's auth state to core layer for share the state with the common
  //
  void _emitAuthSuccess(User user, Emitter<AuthBlocState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccessState(user));
  }
}
