import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:ca_blog_app/core/utils/datetime.dart';
import 'package:ca_blog_app/core/utils/read_time.dart';
import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewScreen extends StatelessWidget {
  static MaterialPageRoute<dynamic> route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewScreen(blog: blog));

  final Blog blog;

  const BlogViewScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  '${blog.postedUser}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  'Posted on: ${blog.updatedAt != null ? formatDateByMMMYYYY(blog.updatedAt!) : 'Unknown'}. ${calculateReadTime(blog.content)} min',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppPalette.greyColor,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(blog.imageUrl ?? '', fit: BoxFit.cover),
                ),
                const SizedBox(height: 20),

                Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16, height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // AppBar for get that back button
  AppBar _appBar(BuildContext context) => AppBar();
}
