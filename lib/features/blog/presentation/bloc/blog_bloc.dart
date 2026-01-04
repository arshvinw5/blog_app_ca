import 'dart:io';

import 'package:ca_blog_app/features/blog/domain/usecases/upload_blogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogs uploadBlogs;

  BlogBloc({required this.uploadBlogs}) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoaded()));
    on<UploadBlogEvent>(_onBlogUpload);
  }

  Future<void> _onBlogUpload(
    UploadBlogEvent event,
    Emitter<BlogState> emit,
  ) async {
    await uploadBlogs(
      UploadBlogsParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        imageFile: event.imageFile,
        categories: event.categories,
      ),
    ).then((result) {
      result.fold(
        (failure) => emit(BlogFailure(message: failure.message)),
        //we are uploading a blog, so no need to return the blog object
        (blog) => emit(BlogUploadSuccess()),
      );
    });
  }
}
