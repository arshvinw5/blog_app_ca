import 'package:ca_blog_app/core/secrets/app_secretes.dart';
import 'package:ca_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:ca_blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ca_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:ca_blog_app/features/auth/domain/usecases/auth_login.dart';
import 'package:ca_blog_app/features/auth/domain/usecases/auth_signup.dart';
import 'package:ca_blog_app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecretes.supabaseUrl,
    anonKey: AppSecretes.supabaseAnonKey,
  );

  //register Supabase client
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
}

void _initAuth() {
  //auth remote data source
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: serviceLocator<SupabaseClient>(),
    ),
  );

  //auth repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator<AuthRemoteDataSource>()),
  );

  //usecases signup
  serviceLocator.registerFactory<UserSignUp>(
    () => UserSignUp(serviceLocator<AuthRepository>()),
  );

  //usecase login
  serviceLocator.registerFactory<UserLogin>(
    () => UserLogin(serviceLocator<AuthRepository>()),
  );

  //auth bloc
  serviceLocator.registerLazySingleton<AuthBlocBloc>(
    () => AuthBlocBloc(
      userSignUp: serviceLocator<UserSignUp>(),
      userLogin: serviceLocator<UserLogin>(),
    ),
  );
}
