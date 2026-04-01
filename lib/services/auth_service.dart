import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future signIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future signUp(String email, String password) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  getCurrentUser() {
    return supabase.auth.currentUser;
  }
}
