import 'package:ca_blog_app/core/theme/theme.dart';
import 'package:ca_blog_app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ca_blog_app/home.dart';
import 'package:ca_blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initDependancies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlocBloc>(
          create: (_) => serviceLocator<AuthBlocBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CA Blog App',
      theme: AppTheme.darkThemeMode,
      home: const Home(),
    );
  }
}
