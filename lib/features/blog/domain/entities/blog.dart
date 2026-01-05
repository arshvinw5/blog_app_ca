// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String? imageUrl;
  final List<String> categories;
  final DateTime? updatedAt;
  final String? postedUser;

  Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.categories,
    this.updatedAt,
    this.postedUser,
  });
}
