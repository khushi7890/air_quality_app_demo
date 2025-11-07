class TodoItem {
  final String text;
  final bool completed;

  TodoItem({required this.text, required this.completed});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      text: json['text'],
      completed: json['completed'],
    );
  }
}