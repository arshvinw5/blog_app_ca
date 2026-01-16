import 'package:ca_blog_app/core/constants/constants.dart';
import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/core/network/connection_checker.dart';
import 'package:ca_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:ca_blog_app/core/common/entities/user.dart';
import 'package:ca_blog_app/features/auth/data/models/user_model.dart';
import 'package:ca_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failures, User>> signIn({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () => remoteDataSource.signinWithCredentials(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failures, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return right(null);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () => remoteDataSource.signupWithCredentials(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  //refactoring code for get user for stop repeating try catch block
  Future<Either<Failures, User>> _getUser(Future<User> Function() fn) async {
    try {
      //to check internet connection
      if (!await (connectionChecker.isConnected)) {
        return left(Failures('No internet connection'));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> getCurrentUserProfile() async {
    try {
      //to check internet connection before making api call to fetch user profile
      //not connected to internet
      if (!await (connectionChecker.isConnected)) {
        //purpose of this is to log the user when the internet is not available
        //then save it in local db for offline access
        final session = remoteDataSource.currentSession;

        //if the session is null then return no internet connection failure
        if (session == null) {
          return left(Failures(Constants.noConnectionErrorMessage));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      // getting string => map of user from data layer then converting to entity in domain layer
      final user = await remoteDataSource.getCurrentUserProfile();

      if (user == null) {
        return left(Failures('No user profile found'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
