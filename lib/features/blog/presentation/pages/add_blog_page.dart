import 'dart:io';

import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:ca_blog_app/core/utils/pick_image.dart';
import 'package:ca_blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:ca_blog_app/features/blog/presentation/widgets/blog_gradient_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Add Blog Page')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              imageFile != null ? _imagePicker() : _dottedBorder(selectImage),
              const SizedBox(height: 20),
              _categoryChip(selectedChips, () {
                setState(() {});
              }),
              const SizedBox(height: 20),
              BlogEditor(controller: titleController, hintText: 'Blog title'),
              const SizedBox(height: 20),
              BlogEditor(
                controller: contentController,
                hintText: 'Blog content',
                minLines: 5,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: BlogGradientButton(
            buttonText: 'Save Blog',
            onTap: () {
              // Add save blog logic here
            },
          ),
        ),
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
      child: Container(
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

Widget _categoryChip(List<String> selectedChips, VoidCallback onUpdate) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: ['Technology', 'Health', 'Travel', 'Education', 'Food']
          .map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  if (selectedChips.contains(category)) {
                    selectedChips.remove(category);
                  } else {
                    selectedChips.add(category);
                  }
                  onUpdate();
                },
                child: Chip(
                  label: Text(category),
                  color: selectedChips.contains(category)
                      ? const WidgetStatePropertyAll(AppPalette.gradient1)
                      : null,
                  side: selectedChips.contains(category)
                      ? null
                      : const BorderSide(color: AppPalette.borderColor),
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}
