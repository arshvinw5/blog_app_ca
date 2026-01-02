import 'package:ca_blog_app/core/common/widgets/loader.dart';
import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final bool isLoading;

  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isLoading = false,
  });

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
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: AppPalette.transparentColor,
          shadowColor: AppPalette.transparentColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: isLoading
            ? const SizedBox(height: 20, width: 20, child: Loader())
            : Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
      ),
    );
  }
}
