import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_item.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000'; // FASTAPI base URL

  Future<List<TodoItem>> fetchTodos() async {
    final response = await http
        .get(Uri.parse('$baseUrl/todos')); // Adjust endpoint to point to todos
    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(response.body); // Parse JSON into TodoItem objects
      return jsonData
          .map((item) => TodoItem.fromJson(item))
          .toList(); // return as list
    } else {
      throw Exception('Failed to load todos'); // Handle error appropriately
    }
  }
}
