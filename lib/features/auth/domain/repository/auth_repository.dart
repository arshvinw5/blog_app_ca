import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, void>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failures, void>> signOut();
}


//TODO : have to chnage return type of successful sign in and sign up to user model 