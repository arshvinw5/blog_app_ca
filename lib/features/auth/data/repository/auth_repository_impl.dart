import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:ca_blog_app/features/auth/domain/entities/user.dart';
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
  Future<Either<Failures, void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
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
}
