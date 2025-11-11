/// A data model representing a single to-do item.
///
/// Each [TodoItem] corresponds to one task in the user's list.
/// It includes an integer ID (unique identifier), a text description,
/// and a completion status flag.
///
/// Example:
/// ```dart
/// final todo = TodoItem(id: 1, text: 'Check indoor air quality', completed: false);
/// ```
class TodoItem {
  /// A unique identifier for the to-do item, assigned by the backend or database.
  final int id;

  /// The text description of the to-do item.
  final String text;

  /// Whether the to-do item has been completed.
  final bool completed;

  /// Creates a new immutable [TodoItem] object.
  ///
  /// All fields are required to ensure each item has
  /// a valid ID, text description, and completion status.
  TodoItem({
    required this.id,
    required this.text,
    required this.completed,
  });

  /// Creates a [TodoItem] instance from a JSON map.
  ///
  /// Typically used when decoding API responses or Firestore documents.
  ///
  /// Throws a [TypeError] if the expected keys are missing or types mismatch.
  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      text: json['text'],
      completed: json['completed'],
    );
  }

  /// Converts this [TodoItem] instance to a JSON-compatible map.
  ///
  /// Used when sending data to APIs or databases.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'completed': completed,
    };
  }

  /// Creates a new [TodoItem] with optional modified fields,
  /// preserving other existing values.
  ///
  /// supports immutable state updates, such as toggling completion or changing the text
  ///
  /// Returns a new [TodoItem] instance with the applied changes.
  TodoItem copyWith({int? id, String? text, bool? completed}) {
    return TodoItem(
      id: id ?? this.id,
      text: text ?? this.text,
      completed: completed ?? this.completed,
    );
  }
}
