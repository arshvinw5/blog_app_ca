import 'package:ca_blog_app/core/cubits/cubit/app_user_cubit.dart';
import 'package:ca_blog_app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ca_blog_app/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppLoggedInState;
      },
      builder: (context, isLoggedIn) {
        if (isLoggedIn) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text('Welcome to CA Blog App! You are logged in.'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBlocBloc>().add(AuthLogout());
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          );
        }
        return const SignInScreen();
      },
    );
  }
}
