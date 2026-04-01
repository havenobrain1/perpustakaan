import '../services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  final AuthService _authService = AuthService();
  final supabase = Supabase.instance.client;

  // ================= LOGIN =================
  Future<String?> login(String email, String password) async {
    try {
      final response = await _authService.signIn(email, password);

      final user = response.user;
      if (user == null) {
        throw Exception("User tidak ditemukan setelah login");
      }

      final data = await supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (data == null) {
        throw Exception("Data user tidak ada di tabel users");
      }

      return data['role'];
    } catch (e) {
      print("LOGIN ERROR: $e");
      rethrow;
    }
  }

  // ================= REGISTER =================
  Future<void> register(String email, String password) async {
    try {
      // 1. Sign Up ke Supabase Auth
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      // ⚠️ Kalau email confirmation aktif, user bisa null
      if (user == null) {
        throw Exception(
          "Registrasi berhasil, tapi perlu konfirmasi email dulu",
        );
      }

      // 2. Insert ke tabel users
      await supabase.from('users').insert({
        'id': user.id,
        'email': email,
        'role': 'siswa', // default role
      });

      print("REGISTER BERHASIL");
    } catch (e) {
      print("REGISTER ERROR: $e");
      rethrow;
    }
  }
}
