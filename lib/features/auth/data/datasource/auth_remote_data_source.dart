import 'package:ca_blog_app/core/error/exceptions.dart';
import 'package:ca_blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentSession;

  Future<UserModel> signupWithCredentials({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signinWithCredentials({
    required String email,
    required String password,
  });

  //to fetch user from user profile table from supabase without parameters
  Future<UserModel?> getCurrentUserProfile();

  //to sign out user
  Future<void> signOut();
}

//purpose of creating this is to make internal data sources calls
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  // this will fetch the user's id and email but need more than that [Profile Table]
  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signupWithCredentials({
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

      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      // we are converting e. to string because it can be of any type
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signinWithCredentials({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException('Signin failed');
      }

      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith(email: currentSession!.user.email);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //To fetch user profile table from supabase
  @override
  Future<UserModel?> getCurrentUserProfile() async {
    try {
      if (currentSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentSession!.user.id)
            .single();

        return UserModel.fromJson(userData).copyWith(
          //we don't email column in profile table so we are getting email from current session
          email: currentSession!.user.email!,
        );
      }
      //if user is not logged in
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() {
    try {
      if (currentSession == null) {
        throw ServerException('No user is currently signed in.');
      }
      return supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

//! => this value is not null
