part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {
  const AuthBlocState();
}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoadingState extends AuthBlocState {}

final class AuthSuccessState extends AuthBlocState {
  final User user;
  const AuthSuccessState(this.user);
}

final class AuthFailureState extends AuthBlocState {
  final String message;
  const AuthFailureState(this.message);
}
