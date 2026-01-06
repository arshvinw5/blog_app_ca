import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogViewScreen extends StatelessWidget {
  static MaterialPageRoute<dynamic> route(String blogTitle) =>
      MaterialPageRoute(
        builder: (context) => BlogViewScreen(blogTitle: blogTitle),
      );

  final String blogTitle;

  const BlogViewScreen({super.key, required this.blogTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context));
  }

  AppBar _appBar(BuildContext context) =>
      AppBar(centerTitle: true, title: Text(blogTitle));
}
