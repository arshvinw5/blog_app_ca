import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:ca_blog_app/core/utils/show_snackbar.dart';
import 'package:ca_blog_app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ca_blog_app/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:ca_blog_app/features/auth/presentation/widgets/auth_feild.dart';
import 'package:ca_blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => const SignInScreen());

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthFailureState) {
              showSnackBar(
                context,
                state.message,
                fontSize: 15.0,
                backgroundColor: AppPalette.errorColor,
                textColor: AppPalette.textColor,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMainText(),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    hintText: "Name ",
                    controller: _nameController,
                  ),
                  const SizedBox(height: 10),
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
                  AuthGradientButton(
                    buttonText: "Sign Up",
                    isLoading: state is AuthLoadingState,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBlocBloc>().add(
                          AuthSignUp(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      }
                      _nameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                    },
                  ),
                  const SizedBox(height: 20),
                  _richText(),
                ],
              ),
            );
          },
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

  Widget _richText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, SignUpScreen.route());
      },
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: TextStyle(color: Colors.grey, fontSize: 16),
          children: [
            TextSpan(
              text: " Sign In",
              style: TextStyle(
                color: AppPalette.gradient2,
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
