import 'package:bloc/bloc.dart';
import 'package:ca_blog_app/features/auth/domain/usecases/auth_signup.dart';
import 'package:flutter/material.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUp _userSignUp;

  //Named Arguments = Called like: AuthBlocBloc(userSignUp: myUserSignUp)

  AuthBlocBloc({required UserSignUp userSignUp})
    : _userSignUp = userSignUp,
      super(AuthBlocInitial()) {
    on<AuthSignUp>(_onSignUp);
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
      (uId) => emit(AuthSuccessState(uId)),
    );
  }
}
