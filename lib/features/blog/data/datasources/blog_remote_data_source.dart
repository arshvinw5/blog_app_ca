import 'dart:io';

import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:ca_blog_app/features/blog/data/models/blog_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  //upload blog to supabase
  Future<BlogModel> uploadBlog(BlogModel blog);

  //to upload image to supabase bucket storage
  Future<String> uploadImage({
    required File imageFile,
    required BlogModel blog,
  });

  //to fetch all the blogs from supabase
  Future<List<BlogModel>> fetchAllBlogsDb();
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
    } on PostgrestException catch (e) {
      // fetching the error from supabase
      throw ServerException(e.message);
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
          .from('blogs_images')
          .upload(blog.id, imageFile);

      //to advance =>
      //upload the images to separate folder inside the storage
      //:upload(${blog.id}/images, imageFile);

      //${blog.id}-> folder name

      //to retrieve the public url of the image
      return supabaseClient.storage.from('blogs_images').getPublicUrl(blog.id);
    } on StorageException catch (e) {
      //fetching the error from supabase storage
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> fetchAllBlogsDb() async {
    try {
      //join profiles table to get the user name
      return await supabaseClient
          .from('blogs')
          .select('*,profiles(name)') // to join profiles table's name column
          .then(
            (blogs) => blogs
                .map(
                  // to convert map to BlogModel
                  (blog) => BlogModel.fromMap(
                    blog,
                  ).copyWith(postedUser: blog['profiles']['name']),
                )
                .toList(),
          );
    } on PostgrestException catch (e) {
      // fetching the error from supabase
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
