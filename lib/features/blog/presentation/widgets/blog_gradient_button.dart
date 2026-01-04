import 'package:ca_blog_app/core/common/widgets/loader.dart';
import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class BlogGradientButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onTap;
  final bool? isLoading;
  const BlogGradientButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isLoading,
  });

  @override
  State<BlogGradientButton> createState() => _BlogGradientButtonState();
}

class _BlogGradientButtonState extends State<BlogGradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppPalette.gradient1,
            AppPalette.gradient2,
            AppPalette.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: widget.onTap,

        style: ElevatedButton.styleFrom(
          fixedSize: Size(395, 55),
          backgroundColor: AppPalette.transparentColor,
          shadowColor: AppPalette.transparentColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: widget.isLoading == true
            ? const SizedBox(height: 20, width: 20, child: Loader())
            : Text(
                widget.buttonText,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
      ),
    );
  }
}
