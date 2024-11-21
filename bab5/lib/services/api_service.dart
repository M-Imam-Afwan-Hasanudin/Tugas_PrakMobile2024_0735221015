import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

const String baseUrl = 'https://events.hmti.unkhair.ac.id/api/books';

Future<List<Book>> fetchBooks() async {
  final response = await http.get(Uri.parse(baseUrl));
  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    return data.map((book) => Book.fromJson(book)).toList();
  } else {
    throw Exception("Gagal memuat data buku");
  }
}

Future<Book> fetchBookById(int id) async {
  final response = await http.get(Uri.parse('$baseUrl/$id'));
  if (response.statusCode == 200) {
    return Book.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Buku tidak ditemukan");
  }
}

Future<void> addBook(String title, String author, String description) async {
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'title': title, 'author': author, 'description': description}),
  );

  if (response.statusCode != 201) {
    throw Exception("Gagal menambahkan buku");
  }
}

Future<void> updateBook(int id, String title, String author, String description) async {
  final response = await http.put(
    Uri.parse('$baseUrl/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'title': title, 'author': author, 'description': description}),
  );

  if (response.statusCode != 200) {
    throw Exception("Gagal memperbarui buku");
  }
}

Future<void> deleteBook(int id) async {
  final response = await http.delete(Uri.parse('$baseUrl/$id'));
  print("Response status: ${response.statusCode}");
  print("Response body: ${response.body}");
  if (response.statusCode != 200 && response.statusCode != 204) {
    print("Error deleting book: ${response.body}");
    throw Exception("Gagal menghapus buku: ${response.body}");
  }
}

