import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:ca_blog_app/features/blog/data/models/blog_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
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
      return BlogModel.fromMap(blogData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
