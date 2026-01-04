import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class BlogEditor extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int minLines;
  final String validator;
  const BlogEditor({
    super.key,
    required this.controller,
    required this.hintText,
    this.minLines = 1,
    required this.validator,
  });

  @override
  State<BlogEditor> createState() => _BlogEditorState();
}

class _BlogEditorState extends State<BlogEditor> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(
          color: _isFocused ? AppPalette.gradient2 : Colors.grey,
        ),
        errorStyle: TextStyle(color: AppPalette.errorColor),

        border: OutlineInputBorder(),
      ),
      minLines: widget.minLines,
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return widget.validator;
        }
        return null;
      },
    );
  }
}
