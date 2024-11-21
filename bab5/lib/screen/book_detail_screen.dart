import 'package:bab5/screen/edit_book_screen.dart';
import 'package:bab5/services/api_service.dart';
import 'package:bab5/models/book.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Penulis: ${book.author}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(book.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditBookScreen(book: book),
                      ),
                    );
                  },
                  child: const Text("Edit"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    print("Deleting book with ID: ${book.id}");
                    try {
                      await deleteBook(book.id); // Panggil API untuk menghapus buku
                      Navigator.pop(context, book.id); // Kirim ID buku yang dihapus
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Gagal menghapus buku: $e")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Hapus"),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
