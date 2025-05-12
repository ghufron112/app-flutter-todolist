import 'package:flutter/material.dart';
import 'second_page.dart'; // Import halaman baru

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => const TodoHomePage(),
        '/second': (context) => const SecondPage(),
      },
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<String> _todos = [];
  final List<String> _filteredTodos = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterTodos);
  }

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _todos.add(text);
        _controller.clear();
      });
      _filterTodos();
    }
  }

  void _removeTodo(int index) {
    final item = _filteredTodos[index];
    setState(() {
      _todos.remove(item);
    });
    _filterTodos();
  }

  void _filterTodos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredTodos
          ..clear()
          ..addAll(_todos);
      } else {
        _filteredTodos
          ..clear()
          ..addAll(_todos.where((todo) => todo.toLowerCase().contains(query)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Inisialisasi filter pertama kali
    if (_filteredTodos.isEmpty && _searchController.text.isEmpty) {
      _filteredTodos.addAll(_todos);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Halaman Kedua',
            onPressed: () => Navigator.pushNamed(context, '/second'),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.pink, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 🔍 Kolom pencarian
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Cari Tugas',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // ✏️ Kolom tambah tugas
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Tambahkan Tugas',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addTodo,
                    child: const Text('Tambah'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 📋 Daftar tugas
              Expanded(
                child:
                    _filteredTodos.isEmpty
                        ? const Center(
                          child: Text('Tidak ada tugas ditemukan.'),
                        )
                        : ListView.builder(
                          itemCount: _filteredTodos.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(_filteredTodos[index]),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _removeTodo(index),
                                ),
                              ),
                            );
                          },
                        ),
              ),
              const SizedBox(height: 10),
              // 🔁 Tombol navigasi alternatif
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/second'),
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Ke Halaman Kedua"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
