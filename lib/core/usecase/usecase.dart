import 'package:ca_blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

//user generic type has be mentioned

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failures, SuccessType>> call(Params params);
}

class NoParams {}
