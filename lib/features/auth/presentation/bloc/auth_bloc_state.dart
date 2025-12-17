part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {
  const AuthBlocState();
}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoadingState extends AuthBlocState {}

final class AuthSuccessState extends AuthBlocState {
  final String userId;
  const AuthSuccessState(this.userId);
}

final class AuthFailureState extends AuthBlocState {
  final String message;
  const AuthFailureState(this.message);
}
