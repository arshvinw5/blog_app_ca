import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/core/usecase/usecase.dart';
import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';
import 'package:ca_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchAllBlogsUseCase implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  FetchAllBlogsUseCase({required this.blogRepository});
  @override
  Future<Either<Failures, List<Blog>>> call(NoParams params) async {
    return await blogRepository.fetchAllBlogsRepo();
  }
}
