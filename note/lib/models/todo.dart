// lib/models/todo.dart
class Todo {
  String id;
  String title;
  DateTime dateTime;  // Đổi tên từ date thành dateTime để rõ ràng hơn
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.dateTime,
    this.isCompleted = false,
  });

  bool get isOverdue {
    final now = DateTime.now();
    return !isCompleted && dateTime.isBefore(DateTime(now.year, now.month, now.day, now.hour, now.minute));
  }
}