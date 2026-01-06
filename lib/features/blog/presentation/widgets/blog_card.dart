import 'package:ca_blog_app/core/utils/read_time.dart';
import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';
import 'package:ca_blog_app/features/blog/presentation/pages/blog_view.dart';
import 'package:ca_blog_app/features/blog/presentation/widgets/blog_chips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  //to add background colors to cards
  final Color color;

  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewScreen.route(blog.title));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16).copyWith(bottom: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlogChips(categories: blog.categories),
                const SizedBox(height: 5.0),
                Text(
                  blog.title,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text('${calculateReadTime(blog.content)} min read'),
          ],
        ),
      ),
    );
  }
}
