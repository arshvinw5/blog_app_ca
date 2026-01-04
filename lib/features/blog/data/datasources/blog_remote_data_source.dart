import 'dart:io';

import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:ca_blog_app/features/blog/data/models/blog_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage({
    required File imageFile,
    required BlogModel blog,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toMap())
          .select()
          .single();

      //cover the json to blog model
      //purpose of converting this to map is get the url from the supabase
      return BlogModel.fromMap(blogData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage({
    required File imageFile,
    required BlogModel blog,
  }) async {
    try {
      //to upload image to supabase storage
      await supabaseClient.storage
          .from('blog_images')
          .upload(blog.id, imageFile);

      //to advance =>
      //upload the images to separate folder inside the storage
      //:upload(${blog.id}/images, imageFile);

      //${blog.id}-> folder name

      //to retrieve the public url of the image
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
