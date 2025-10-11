import 'package:flutter/material.dart';
import 'pages/books_column_page.dart';
import 'pages/books_listview_page.dart';
import 'pages/books_separated_page.dart';

void main() {
  runApp(const BooksApp());
}

class BooksApp extends StatefulWidget {
  const BooksApp({super.key});

  @override
  State<BooksApp> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BooksColumnPage(),
    BooksListViewPage(),
    BooksSeparatedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Каталог книг',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Каталог книг'),
          centerTitle: true,
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Column',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'ListView',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Separated',
            ),
          ],
        ),
      ),
    );
