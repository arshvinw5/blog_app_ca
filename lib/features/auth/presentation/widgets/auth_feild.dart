import 'package:ca_blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  const CustomTextFormField({super.key, this.hintText});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
      focusNode: _focusNode,
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(
          color: _isFocused ? AppPallete.gradient2 : Colors.grey,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
