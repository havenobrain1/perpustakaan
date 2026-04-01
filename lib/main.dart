import 'package:flutter/material.dart';
import 'package:flutter_perpustakaan/views/pages/add_book_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'views/pages/login_page.dart';
import 'views/pages/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bsknqanfkjfjjjrbamlc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJza25xYW5ma2pmampqcmJhbWxjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ4OTgzMTMsImV4cCI6MjA5MDQ3NDMxM30.gwRSRI1SKmOnao2lXWWFOI7C0gHm3rBBKXS9oWI4xHM',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // halaman pertama
      initialRoute: '/',

      // 🔥 ROUTING UTAMA
      routes: <String, WidgetBuilder>{
        '/': (context) => const LoginPage(),
        '/siswa': (context) => const DashboardPage(),
        '/admin': (context) => const DashboardPage(),
        '/admin/add-book': (context) => const AddBookPage(),
      },

      // 🔥 fallback kalau route tidak ditemukan
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Halaman tidak ditemukan")),
          ),
        );
      },
    );
  }
}
