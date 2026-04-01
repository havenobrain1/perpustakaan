import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'book_page.dart';
import 'add_book_page.dart';
import 'login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String role = '';

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  // 🔥 Ambil role dari Supabase
  Future<void> getUserRole() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      final data = await Supabase.instance.client
          .from('users')
          .select('role')
          .eq('id', user.id)
          .single();

      setState(() {
        role = data['role'];
      });
    }
  }

  // 🔓 Logout
  Future<void> logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = role == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Info Role
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(width: 10),
                  Text(
                    role.isEmpty ? "Loading..." : "Role: $role",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🔐 ADMIN ONLY
            if (isAdmin)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah Buku"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddBookPage()),
                    );
                  },
                ),
              ),

            if (isAdmin) const SizedBox(height: 12),

            // 📚 SEMUA USER
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.menu_book),
                label: const Text("Lihat Buku"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BookPage()),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // 🚪 LOGOUT
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => logout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
