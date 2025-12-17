import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signupWithCredentials({
    required String name,
    required String email,
    required String password,
  });

  // Future<String> signinWithCredentials({
  //   required String email,
  //   required String password,
  // });
}

//pupose of creating this is to mkae internal data sources calls
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<String> signupWithCredentials({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw ServerException('Signup failed');
      }

      return response.user?.id ?? '';
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<String> signinWithCredentials({
  //   required String email,
  //   required String password,
  // }) async {
  //   //TODO: implement signinWithCredentials
  // }
}
