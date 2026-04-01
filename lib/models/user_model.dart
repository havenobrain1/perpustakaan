class UserModel {
  final String id;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
  });

  // dari JSON (Supabase → Flutter)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      role: json['role'],
    );
  }

  // ke JSON (Flutter → Supabase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
    };
  }
}