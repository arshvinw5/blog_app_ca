part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class UploadBlogEvent extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File imageFile;
  final List<String> categories;

  UploadBlogEvent({
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageFile,
    required this.categories,
  });
}
