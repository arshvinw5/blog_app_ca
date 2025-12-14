import 'package:ca_blog_app/core/theme/theme.dart';
import 'package:ca_blog_app/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CA Blog App',
      theme: AppTheme.darkThemeMode,
      home: const Home(),
    );
  }
}
