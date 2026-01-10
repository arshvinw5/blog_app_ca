import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/core/usecase/usecase.dart';
import 'package:ca_blog_app/core/common/entities/user.dart';
import 'package:ca_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  AuthRepository authRepository;

  CurrentUser({required this.authRepository});
  @override
  Future<Either<Failures, User>> call(NoParams params) async {
    return await authRepository.getCurrentUserProfile();
  }
}
