part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecretes.supabaseUrl,
    anonKey: AppSecretes.supabaseAnonKey,
  );

  //initialize hive and open box
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  //register open box for blogs
  serviceLocator.registerLazySingleton<Box>(() => Hive.box(name: 'blogs'));

  //register Supabase client
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);

  //register AppUserCubit
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());

  serviceLocator.registerFactory(
    () => InternetConnectionChecker.createInstance(),
  );

  //to register ConnectionChecker
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator<InternetConnectionChecker>()),
  );
}

void _initAuth() {
  //auth remote data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator<SupabaseClient>(),
      ),
    )
    //auth repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    //usecase signup
    ..registerFactory<UserSignUp>(
      () => UserSignUp(serviceLocator<AuthRepository>()),
    )
    //usecase login
    //this is positional parameter style and argument is passed by position [order of the parameters is matters ]
    ..registerFactory<UserLogin>(
      () => UserLogin(serviceLocator<AuthRepository>()),
    )
    //userlogout
    ..registerFactory<UserSignOut>(
      () => UserSignOut(serviceLocator<AuthRepository>()),
    )
    //usecase current user
    //this is named parameter style and argument is passed by specific name
    ..registerFactory<CurrentUser>(
      () => CurrentUser(authRepository: serviceLocator<AuthRepository>()),
    )
    //auth bloc
    ..registerLazySingleton<AuthBlocBloc>(
      () => AuthBlocBloc(
        userSignUp: serviceLocator<UserSignUp>(),
        userLogin: serviceLocator<UserLogin>(),
        currentUser: serviceLocator<CurrentUser>(),
        userSignOut: serviceLocator<UserSignOut>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    //blog remote data source
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        supabaseClient: serviceLocator<SupabaseClient>(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(serviceLocator<Box>()),
    )
    //blog repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        remoteDataSource: serviceLocator<BlogRemoteDataSource>(),
        localDataSource: serviceLocator<BlogLocalDataSource>(),
        connectionChecker: serviceLocator<ConnectionChecker>(),
      ),
    )
    //usecase upload blogs
    ..registerFactory<UploadBlogs>(
      () => UploadBlogs(repository: serviceLocator<BlogRepository>()),
    )
    //usecase fetch all blogs
    ..registerFactory<FetchAllBlogsUseCase>(
      () => FetchAllBlogsUseCase(
        blogRepository: serviceLocator<BlogRepository>(),
      ),
    )
    //blog bloc
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        uploadBlogs: serviceLocator<UploadBlogs>(),
        fetchAllBlogs: serviceLocator<FetchAllBlogsUseCase>(),
      ),
    );
}
