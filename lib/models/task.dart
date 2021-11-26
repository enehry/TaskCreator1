import 'dart:convert';

class Task {
  final String title;
  bool isDone;

  Task({required this.title, this.isDone = false});

  void triggerIsDone() {
    isDone = !isDone;
  }

  factory Task.fromJson(Map<String, dynamic> task) {
    return Task(title: task['title'], isDone: task['isDone']);
  }

  static Map<String, dynamic> toJson(Task task) =>
      {'title': task.title, 'isDone': task.isDone};

  static String encode(List<Task> tasks) {
    return json.encode(tasks.map((task) => Task.toJson(task)).toList());
  }

  static List<Task> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map((task) => Task.fromJson(task))
          .toList();
}
