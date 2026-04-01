class BookModel {
  final String id;
  final String title;
  final String author;
  final int stock;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.stock,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'author': author, 'stock': stock};
  }
}
