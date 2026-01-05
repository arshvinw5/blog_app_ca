import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:ca_blog_app/core/utils/show_snackbar.dart';
import 'package:ca_blog_app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ca_blog_app/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:ca_blog_app/features/auth/presentation/widgets/auth_feild.dart';
import 'package:ca_blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => const SignInScreen());

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
        child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthFailureState) {
              showSnackBar(
                context,
                state.message,
                textColor: AppPalette.textColor,
                backgroundColor: AppPalette.errorColor,
                fontSize: 15.0,
              );
            } else if (state is AuthSuccessState) {
              print("User from user model: ${state.user.email}");
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
                    buttonText: "Sign In",
                    isLoading: state is AuthLoadingState,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBlocBloc>().add(
                          AuthLogin(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      }
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
      "Welcome Back",
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
          text: "Don't have an account?",
          style: TextStyle(color: Colors.grey, fontSize: 16),
          children: [
            TextSpan(
              text: " Sign Up",
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
