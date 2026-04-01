import 'package:flutter/material.dart';
import '../../services/book_service.dart';

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final service = BookService();
  List books = [];

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  void loadBooks() async {
    final data = await service.getBooks();
    setState(() {
      books = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buku")),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (_, i) {
          return ListTile(
            title: Text(books[i]['title']),
            subtitle: Text(books[i]['author']),
          );
        },
      ),
    );
  }
}
