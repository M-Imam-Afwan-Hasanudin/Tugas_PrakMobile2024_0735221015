import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddBookScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Buku Baru")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'Penulis'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await addBook(
                  titleController.text,
                  authorController.text,
                  descriptionController.text,
                );
                Navigator.pop(context); // Kembali ke daftar buku
              },
              child: const Text("Tambah Buku"),
            ),
          ],
        ),
      ),
    );
  }
}
