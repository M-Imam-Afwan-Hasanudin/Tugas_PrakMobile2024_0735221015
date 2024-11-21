class Book {
  final int id; // Tambahkan ID
  final String title;
  final String author;
  final String description;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'], // Tambahkan ID di sini
      title: json['title'],
      author: json['author'],
      description: json['description'],
    );
  }
}
