import 'package:ca_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  //to add background colors to cards
  final Color color;

  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: blog.categories
                  .map(
                    (category) => Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Chip(label: Text(category)),
                    ),
                  )
                  .toList(),
            ),
          ),
          Text(blog.title),
        ],
      ),
    );
  }
}
