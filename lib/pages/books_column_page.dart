import 'package:flutter/material.dart';

class BooksColumnPage extends StatefulWidget {
  const BooksColumnPage({super.key});

  @override
  State<BooksColumnPage> createState() => _BooksColumnPageState();
}

class _BooksColumnPageState extends State<BooksColumnPage> {
  final List<Map<String, dynamic>> _books = [
    {'title': 'Мастер и Маргарита', 'author': 'М. Булгаков', 'pages': 100},
    {'title': 'Преступление и наказание', 'author': 'Ф. Достоевский', 'pages': 50},
    {'title': 'Три товарища', 'author': 'Э. М. Ремарк', 'pages': 70},
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  void _addBook() {
    final title = _titleController.text.trim();
    final author = _authorController.text.trim();
    if (title.isEmpty || author.isEmpty) return;

    setState(() {
      _books.add({'title': title, 'author': author, 'pages': 0});
      _titleController.clear();
      _authorController.clear();
    });
  }

  void _removeBook(int index) {
    setState(() {
      _books.removeAt(index);
    });
  }

  void _changePages(int index, int delta) {
    setState(() {
      final current = _books[index]['pages'];
      final updated = (current + delta).clamp(0, 10000);
      _books[index]['pages'] = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Список книг (Column + ScrollView)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ..._books.asMap().entries.map((entry) {
            final index = entry.key;
            final book = entry.value;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(book['title']),
                subtitle: Text('${book['author']} — ${book['pages']} стр.'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => _changePages(index, -10),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _changePages(index, 10),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _removeBook(index),
                    ),
                  ],
                ),
              ),
            );
          }),
          const Divider(height: 24, thickness: 1),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Название книги'),
          ),
          TextField(
            controller: _authorController,
            decoration: const InputDecoration(labelText: 'Автор'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _addBook,
            child: const Text('Добавить книгу'),
          ),
        ],
      ),
    );
  }
}
