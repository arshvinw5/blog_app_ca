import 'package:ca_blog_app/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      // Handle both formats: direct 'name' field (from profiles table)
      // or nested in 'user_metadata' (from auth response)
      name: json['name'] ?? json['user_metadata']?['name'] ?? '',
    );
  }

  //to have a copy of user model with modified fields
  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
