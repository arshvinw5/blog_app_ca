import 'dart:io';

import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:ca_blog_app/core/error/failures.dart';
import 'package:ca_blog_app/core/network/connection_checker.dart';
import 'package:ca_blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:ca_blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:ca_blog_app/features/blog/data/models/blog_models.dart';
import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';
import 'package:ca_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final BlogLocalDataSource localDataSource;
  final ConnectionChecker connectionChecker;

  //dependency injection
  BlogRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File imageFile,
    required String title,
    required String content,
    required String posterId,
    required List<String> categories,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return Left(Failures('No internet connection'));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        title: title,
        content: content,
        imageUrl: '',
        posterId: posterId,
        categories: categories,
        updatedAt: DateTime.now(),
      );

      //to get the image url after store it in supabase
      final imageUrl = await remoteDataSource.uploadImage(
        imageFile: imageFile,
        blog: blogModel,
      );

      //then we need to update the blog model with the image url
      //this is why we need the copy with method in the blog model
      // we can't directly assign the image url because the blog model is immutable
      //for the reason : Thread Safety

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await remoteDataSource.uploadBlog(blogModel);

      return Right(uploadedBlog);
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    }
  }

  //to fetch all the blogs from supabase
  @override
  Future<Either<Failures, List<Blog>>> fetchAllBlogsRepo() async {
    try {
      if (!await connectionChecker.isConnected) {
        //if no internet connection fetch from local db
        final localBlogs = localDataSource.getLocalBlogs();
        return Right(localBlogs);
      }

      return await remoteDataSource.fetchAllBlogsDb().then((blogModels) {
        //after fetching from remote db store it in local db
        localDataSource.uploadLocalBlogs(blogs: blogModels);
        return Right(blogModels);
      });
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    }
  }
}
