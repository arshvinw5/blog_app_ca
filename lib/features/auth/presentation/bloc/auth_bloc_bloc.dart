import 'package:bloc/bloc.dart';
import 'package:ca_blog_app/features/auth/domain/entities/user.dart';
import 'package:ca_blog_app/features/auth/domain/usecases/auth_login.dart';
import 'package:ca_blog_app/features/auth/domain/usecases/auth_signup.dart';
import 'package:flutter/material.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  //Named Arguments = Called like: AuthBlocBloc(userSignUp: myUserSignUp)

  AuthBlocBloc({required UserSignUp userSignUp, required UserLogin userLogin})
    : _userSignUp = userSignUp,
      _userLogin = userLogin,

      super(AuthBlocInitial()) {
    on<AuthSignUp>(_onSignUp);
    on<AuthLogin>(_onLogin);
  }

  void _onSignUp(AuthSignUp event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState());

    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    //this is the place to return success or failure states
    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => emit(AuthSuccessState(user)),
    );
  }

  void _onLogin(AuthLogin event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState());

    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );

    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => emit(AuthSuccessState(user)),
    );
  }
}
