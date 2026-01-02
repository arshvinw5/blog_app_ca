import 'dart:io';

import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failures, Blog>> uploadBlog({
    required File imageFile,
    required String title,
    required String content,
    required String posterId,
    required List<String> categories,
  });
}
