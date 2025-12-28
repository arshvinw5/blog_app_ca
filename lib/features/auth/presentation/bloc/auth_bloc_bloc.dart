import 'package:bloc/bloc.dart';
import 'package:ca_blog_app/core/usecase/usecase.dart';
import 'package:ca_blog_app/features/auth/domain/entities/user.dart';
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

  AuthBlocBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
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
      (user) => emit(AuthSuccessState(user)),
    );
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState());

    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => emit(AuthSuccessState(user)),
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
        emit(AuthSuccessState(user));
      },
    );
  }
}
