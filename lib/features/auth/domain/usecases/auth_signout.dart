import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/core/usecase/usecase.dart';
import 'package:ca_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOut implements UseCase<void, NoParams> {
  final AuthRepository repository;

  UserSignOut(this.repository);

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
