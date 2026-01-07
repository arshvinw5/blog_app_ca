import 'package:ca_blog_app/features/blog/data/models/blog_models.dart';
import 'package:hive/hive.dart';

abstract interface class AuthLocalDataSource {
  //none of the fn are future due to local db operations
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> getLocalBlogs();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box box;

  const AuthLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> getLocalBlogs() {}

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.write(
      () => {
        //index + item
        for (int i = 0; i < blogs.length; i++)
          {box.put(i.toString(), blogs[i])},
      },
    );
  }
}
