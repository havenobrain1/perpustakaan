import 'package:supabase_flutter/supabase_flutter.dart';

class BookService {
  final supabase = Supabase.instance.client;

  Future<List> getBooks() async {
    return await supabase.from('books').select();
  }

  Future<void> addBook(String title, String author, int stock) async {
    await supabase.from('books').insert({
      'title': title,
      'author': author,
      'stock': stock,
    });
  }
}
