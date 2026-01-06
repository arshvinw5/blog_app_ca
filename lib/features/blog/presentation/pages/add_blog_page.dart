import 'dart:io';

import 'package:ca_blog_app/core/cubits/cubit/app_user_cubit.dart';
import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:ca_blog_app/core/utils/pick_image.dart';
import 'package:ca_blog_app/core/utils/show_snackbar.dart';
import 'package:ca_blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:ca_blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:ca_blog_app/features/blog/presentation/widgets/blog_chips.dart';
import 'package:ca_blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:ca_blog_app/features/blog/presentation/widgets/blog_gradient_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogPage extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => const AddBlogPage());

  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  //form key
  final formKey = GlobalKey<FormState>();

  //array for get the values of chips
  List<String> selectedChips = [];

  //to hold the image in vehicle state
  File? imageFile;

  //to image picker fn
  void selectImage() async {
    final pickedImage = await pickImageFromGallery();

    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
    }
  }

  void _removeImage() {
    setState(() {
      imageFile = null;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  //fn to upload the blog
  void _uploadBlog() {
    // you can use isNotEmpty instead of length >= 1
    if (formKey.currentState!.validate() &&
        selectedChips.isNotEmpty &&
        imageFile != null) {
      //to get the postedId from user bloc
      final postedId =
          (context.read<AppUserCubit>().state as AppLoggedInState).user.id;
      context.read<BlogBloc>().add(
        UploadBlogEvent(
          posterId: postedId,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          categories: selectedChips,
          imageFile: imageFile!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Add Blog Page')),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          } else if (state is BlogUploadSuccess) {
            //have to add snackbar
            showSnackBar(
              context,
              'Blog uploaded successfully',
              backgroundColor: AppPalette.gradient3,
            );
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    imageFile != null
                        ? _imagePicker()
                        : _dottedBorder(selectImage),
                    const SizedBox(height: 20),
                    BlogChips(
                      selectedChips: selectedChips,
                      onUpdate: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    BlogEditor(
                      controller: titleController,
                      hintText: 'Blog title',
                      validator: 'Blog title is required',
                    ),
                    const SizedBox(height: 20),
                    BlogEditor(
                      controller: contentController,
                      hintText: 'Blog content',
                      minLines: 5,
                      validator: 'Blog content is required',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: BlogGradientButton(
                isLoading: state is BlogLoading,
                buttonText: 'Save Blog',
                onTap: _uploadBlog,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _imagePicker() {
    return Stack(
      children: [
        GestureDetector(
          onTap: selectImage,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              imageFile!,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: _removeImage,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _dottedBorder(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: const [10, 4],
        strokeWidth: 2,
        color: AppPalette.borderColor,
        radius: const Radius.circular(12),
      ),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 40),
            SizedBox(height: 10),
            Text(
              'Select Blog Image',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}

// Widget _categoryChip(List<String> selectedChips, VoidCallback onUpdate) {
//   return SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//       children: ['Technology', 'Health', 'Travel', 'Education', 'Food']
//           .map(
//             (category) => Padding(
//               padding: const EdgeInsets.only(right: 10.0),
//               child: GestureDetector(
//                 onTap: () {
//                   if (selectedChips.contains(category)) {
//                     selectedChips.remove(category);
//                   } else {
//                     selectedChips.add(category);
//                   }
//                   onUpdate();
//                 },
//                 child: Chip(
//                   label: Text(category),
//                   color: selectedChips.contains(category)
//                       ? const WidgetStatePropertyAll(AppPalette.gradient1)
//                       : null,
//                   side: selectedChips.contains(category)
//                       ? null
//                       : const BorderSide(color: AppPalette.borderColor),
//                 ),
//               ),
//             ),
//           )
//           .toList(),
//     ),
//   );
// }
