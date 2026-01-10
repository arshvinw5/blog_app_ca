import 'package:ca_blog_app/features/blog/data/models/blog_models.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  //none of the fn are future due to local db operations
  void uploadLocalBlogs({required List<BlogModel> blogs});

  //to return blogs from local db
  List<BlogModel> getLocalBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  const BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> getLocalBlogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        //get each map from box and convert to BlogModel
        final map = box.get(i.toString()) as Map<String, dynamic>;
        blogs.add(BlogModel.fromMap(map));
      }
    });

    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    //clear existing data in box before adding new data
    //to avoid duplicate data
    box.clear();
    box.write(
      () => {
        //index + item
        for (int i = 0; i < blogs.length; i++)
          {box.put(i.toString(), blogs[i].toMap())},
      },
    );
  }
}


//hive write : A transaction is a way to group multiple database
// operations together so they are treated as a single atomic unit.
//wite is exisiting in cummit package but not in hive package