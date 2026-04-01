import 'package:flutter/material.dart';
import '../../services/book_service.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final stockController = TextEditingController();

  final service = BookService();

  void saveBook() async {
    await service.addBook(
      titleController.text,
      authorController.text,
      int.parse(stockController.text),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Buku berhasil ditambahkan")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Buku")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Judul Buku"),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: "Penulis"),
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: "Stok"),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: saveBook, child: const Text("Simpan")),
          ],
        ),
      ),
    );
  }
}
