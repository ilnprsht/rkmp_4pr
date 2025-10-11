import 'package:flutter/material.dart';

class BooksListViewPage extends StatefulWidget {
  const BooksListViewPage({super.key});

  @override
  State<BooksListViewPage> createState() => _BooksListViewPageState();
}

class _BooksListViewPageState extends State<BooksListViewPage> {
  final List<Map<String, dynamic>> _books = [
    {'title': '1984', 'author': 'Дж. Оруэлл', 'pages': 120},
    {'title': 'Улисс', 'author': 'Дж. Джойс', 'pages': 90},
    {'title': 'Пикник на обочине', 'author': 'Стругацкие', 'pages': 75},
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
    setState(() => _books.removeAt(index));
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Список книг (ListView)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: _books.asMap().entries.map((entry) {
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
              }).toList(),
            ),
          ),
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
