// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_item.dart';
import '../widgets/add_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Todo> _todos = [];

  void _addTodo(String title, DateTime date) {
    setState(() {
      _todos.add(
        Todo(id: DateTime.now().toString(), title: title, dateTime: date),
      );
    });
  }

  void _toggleTodo(String id, bool? isCompleted) {
    setState(() {
      final todo = _todos.firstWhere((todo) => todo.id == id);
      todo.isCompleted = isCompleted ?? false;
    });
  }

  bool get _allTasksCompleted {
    if (_todos.isEmpty) return false;
    return _todos.every((todo) => todo.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách công việc'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          if (_allTasksCompleted && _todos.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.green.shade100,
              width: double.infinity,
              child: const Text(
                'Chúc mừng! Bạn đã hoàn thành tất cả công việc hôm nay! 🎉',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child:
                _todos.isEmpty
                    ? const Center(
                      child: Text(
                        'Chưa có công việc nào.\nHãy thêm công việc mới!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                    : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        final todo = _todos[index];
                        return TodoItem(
                          todo: todo,
                          onToggle:
                              (isCompleted) =>
                                  _toggleTodo(todo.id, isCompleted),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder:
                (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: AddTodo(onAdd: _addTodo),
                ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
