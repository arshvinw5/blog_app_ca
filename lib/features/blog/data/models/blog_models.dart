import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    super.imageUrl,
    required super.categories,
    super.updatedAt,
    super.posterName,
  });

  //this reason to handle null :
  //mage_url text,        -- Can be NULL
  //updated_at timestamp,  -- Can be NULL
  //Supabase

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String?, // Handle null
      categories: List<String>.from(map['topics'] ?? []), // Handle null array
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null, // Handle null date
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': categories,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  //CopyWith method has been created for easy modification of BlogModel instances since they are immutable.
  //can't modify the existing instance, but can create a new instance with modified fields.

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? categories,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      categories: categories ?? this.categories,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
