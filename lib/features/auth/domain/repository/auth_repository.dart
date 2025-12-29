import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, User>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failures, void>> signOut();

  //to fetch user profile without parameters
  Future<Either<Failures, User>> getCurrentUserProfile();
}
