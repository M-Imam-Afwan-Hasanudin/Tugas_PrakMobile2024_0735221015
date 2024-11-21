import 'package:bab5/screen/books_list_screen.dart';
import 'package:flutter/material.dart';
import 'screens/books_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Buku',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BooksListScreen(),
    );
  }
}
