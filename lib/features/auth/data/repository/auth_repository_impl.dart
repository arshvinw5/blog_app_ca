import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:ca_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, void>> signIn({
    required String email,
    required String password,
  }) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, String>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signupWithCredentials(
        name: name,
        email: email,
        password: password,
      );

      return right(userId);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
