// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/core/usecase/usecase.dart';
import 'package:ca_blog_app/features/auth/domain/entities/user.dart';
import 'package:ca_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failures, User>> call(UserSignUpParams params) async {
    return await authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
