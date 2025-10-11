import 'package:flutter/material.dart';

class BooksSeparatedPage extends StatefulWidget {
  const BooksSeparatedPage({super.key});

  @override
  State<BooksSeparatedPage> createState() => _BooksSeparatedPageState();
}

class _BooksSeparatedPageState extends State<BooksSeparatedPage> {
  final List<Map<String, dynamic>> _books = [
    {'id': 1, 'title': 'Цветы для Элджернона', 'author': 'Д. Киз', 'pages': 130},
    {'id': 2, 'title': 'Маленький принц', 'author': 'А. де Сент-Экзюпери', 'pages': 60},
    {'id': 3, 'title': 'Собачье сердце', 'author': 'М. Булгаков', 'pages': 110},
  ];

  void _removeBook(int id) {
    setState(() => _books.removeWhere((book) => book['id'] == id));
  }

  void _changePages(int id, int delta) {
    setState(() {
      final book = _books.firstWhere((b) => b['id'] == id);
      final current = book['pages'];
      final updated = (current + delta).clamp(0, 10000);
      book['pages'] = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Список книг (ListView.separated)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: _books.length,
              separatorBuilder: (context, index) =>
              const Divider(color: Colors.indigo, thickness: 1),
              itemBuilder: (context, index) {
                final book = _books[index];
                return ListTile(
                  key: ValueKey(book['id']),
                  title: Text(book['title']),
                  subtitle: Text('${book['author']} — ${book['pages']} стр.'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _changePages(book['id'], -10),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _changePages(book['id'], 10),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _removeBook(book['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
