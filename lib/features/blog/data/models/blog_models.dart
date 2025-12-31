import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';

class BlogModels extends Blog {
  BlogModels({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.categories,
    required super.updatedAt,
  });
}
