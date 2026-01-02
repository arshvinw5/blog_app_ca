import 'dart:io';

import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/core/usecase/usecase.dart';
import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';
import 'package:ca_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogs implements UseCase<Blog, UploadBlogsParams> {
  BlogRepository repository;

  UploadBlogs({required this.repository});
  @override
  Future<Either<Failures, Blog>> call(UploadBlogsParams params) async {
    return await repository.uploadBlog(
      imageFile: params.imageFile,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      categories: params.categories,
    );
  }
}

class UploadBlogsParams {
  final String posterId;
  final String title;
  final String content;
  final File imageFile;
  final List<String> categories;

  UploadBlogsParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageFile,
    required this.categories,
  });
}
