part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppLoggedInState extends AppUserState {
  final User user;
  AppLoggedInState(this.user);
}
