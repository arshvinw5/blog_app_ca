import 'package:ca_blog_app/features/auth/presentation/widgets/auth_feild.dart';
import 'package:ca_blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMainText(),
            const SizedBox(height: 30),
            CustomTextFormField(hintText: "Name "),
            const SizedBox(height: 10),
            CustomTextFormField(hintText: "Email"),
            const SizedBox(height: 10),
            CustomTextFormField(hintText: "Password"),
            const SizedBox(height: 30),
            const AuthGradientButton(),
          ],
        ),
      ),
    );
  }

  // Main Text
  Widget _buildMainText() {
    return Text(
      "Sign Up",
      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
    );
  }
}
