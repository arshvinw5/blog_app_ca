import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.categories,
    required super.updatedAt,
  });

  //if we are having error then change the column name with "topics"
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': categories,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['posterId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      categories: List<String>.from(map['topics'] ?? []),
      updatedAt: map['updated_at'] != null
          ? DateTime.now()
          : DateTime.parse(map['updated_at'] as String),
    );
  }
}
