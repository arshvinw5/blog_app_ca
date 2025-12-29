import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:ca_blog_app/core/common/entities/user.dart';
import 'package:ca_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

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
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> getCurrentUserProfile() async {
    try {
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
