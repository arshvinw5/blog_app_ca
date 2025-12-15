import 'package:ca_blog_app/core/theme/app_pallete.dart';
import 'package:ca_blog_app/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:ca_blog_app/features/auth/presentation/widgets/auth_feild.dart';
import 'package:ca_blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => const SignUpScreen());

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMainText(),
              const SizedBox(height: 30),
              CustomTextFormField(
                hintText: "Email",
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hintText: "Password",
                controller: _passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 30),
              const AuthGradientButton(buttonText: "Sign In"),
              const SizedBox(height: 20),
              _richText(),
            ],
          ),
        ),
      ),
    );
  }

  // Main Text
  Widget _buildMainText() {
    return Text(
      "Welcome Back",
      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
    );
  }

  Widget _richText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, SignInScreen.route());
      },
      child: RichText(
        text: TextSpan(
          text: "Don't have an account?",
          style: TextStyle(color: Colors.grey, fontSize: 16),
          children: [
            TextSpan(
              text: " Sign Up",
              style: TextStyle(
                color: AppPallete.gradient2,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
