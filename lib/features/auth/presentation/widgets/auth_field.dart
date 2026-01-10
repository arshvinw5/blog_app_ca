import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool isObscureText;
  const CustomTextFormField({
    super.key,
    this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isPasswordVisible = false;

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
      focusNode: _focusNode,
      obscureText: widget.isObscureText && !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(
          color: _isFocused ? AppPalette.gradient2 : Colors.grey,
        ),
        border: OutlineInputBorder(),
        suffixIcon: widget.isObscureText && _isFocused
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: _isFocused ? AppPalette.gradient2 : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }
}
