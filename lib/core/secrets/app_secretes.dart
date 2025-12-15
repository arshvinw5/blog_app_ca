import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecretes {
  static String supabaseUrl = dotenv.env['SUPERBASE_URL'] ?? '';
  static String supabaseAnonKey = dotenv.env['SUPERBASE_ANON_KEY'] ?? '';
}
