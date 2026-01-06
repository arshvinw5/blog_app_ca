import 'package:ca_blog_app/core/common/widgets/loader.dart';
import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:ca_blog_app/core/utils/show_snackbar.dart';
import 'package:ca_blog_app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ca_blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:ca_blog_app/features/blog/presentation/pages/add_blog_page.dart';
import 'package:ca_blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => const BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(FetchAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(context),
      appBar: _appBar(context),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          } else if (state is BlogDisplaySuccess) {
            //display list of blogs
            final blogs = state.blogs;
            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 3 == 0
                      ? AppPalette.gradient1
                      : index % 3 == 1
                      ? AppPalette.gradient2
                      : AppPalette.gradient3,
                );
              },
            );
          } else {
            return const Center(child: Text('No Blogs Available'));
          }
        },
      ),
    );
  }

  //app bar
  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Blog Page'),
      actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.add_circled),
          onPressed: () {
            Navigator.push(context, AddBlogPage.route());
          },
        ),
      ],
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppPalette.gradient1,
                  AppPalette.gradient2,
                  AppPalette.gradient3,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(leading: Icon(Icons.home), title: Text('Home')),
          ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          GestureDetector(
            onTap: () {
              // Trigger logout event
              context.read<AuthBlocBloc>().add(AuthLogout());
            },
            child: ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
