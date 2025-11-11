import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:air_quality_app_demo/app/core/models/todo_item.dart';
import 'package:air_quality_app_demo/app/core/models/sensor_data.dart';

/// Provides HTTP methods to communicate with FastAPI.
///
/// Handles CRUD operations for `TodoItem`s and data retrieval for sensors.
/// `baseUrl` should typically be set to `http://10.0.2.2:8000` when
/// running on the Android emulator.
class ServiceFastAPI {
  ///Base URL for FastAPI backend should be http://10.0.2.2:8000
  ///
  /// 10.0.2.2 is the special address that points to localhost on Android emulator.
  final String baseUrl;
  ServiceFastAPI({required this.baseUrl});

  // ---------------------------------------------------------------------------
  // ENDPOINTS FOR TODOS
  // ---------------------------------------------------------------------------

  /// Fetches all ToDo items from the FastAPI backend.
  ///
  /// **Returns:** A list of [TodoItem] objects.
  /// **Throws:** [Exception] if the request fails or the server returns
  /// a non-200 status code.
  Future<List<TodoItem>> getTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => TodoItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos (status ${response.statusCode})');
    }
  }

  /// Creates a new to-do item on the backend.
  ///
  /// **Parameters:** [jsonBody] – A map representing the to-do’s fields.
  /// **Returns:** The created [TodoItem].
  /// **Throws:** [Exception] if creation fails or the server returns
  /// a non-200/201 status code.
  Future<TodoItem> createTodo(Map<String, dynamic> jsonBody) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TodoItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create todo (status ${response.statusCode})');
    }
  }

  /// Updates an existing to-do item.
  ///
  /// **Parameters:**
  /// - [id]: The ID of the to-do to update.
  /// - [jsonBody]: The updated field values.
  ///
  /// **Throws:** [Exception] if the update fails or the server returns
  /// a non-200 status code.
  Future<void> updateTodo(int id, Map<String, dynamic> jsonBody) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonBody),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo (status ${response.statusCode})');
    }
  }

  /// Deletes a to-do item by ID.
  ///
  /// **Throws:** [Exception] if deletion fails or the server returns
  /// a non-200 status code.
  Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/todos/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo (status ${response.statusCode})');
    }
  }

  /// Marks a to-do item as complete.
  ///
  /// **Throws:** [Exception] if the backend request fails or the server returns
  /// a non-200 status code.
  Future<void> markComplete(int id) async {
    final response = await http.post(Uri.parse('$baseUrl/todos/$id/complete'));

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to mark todo as complete (status ${response.statusCode})');
    }
  }

  /// Marks a to-do item as incomplete.
  ///
  /// **Throws:** [Exception] if the backend request fails or the server returns
  /// a non-200 status code.
  Future<void> markIncomplete(int id) async {
    final response =
        await http.post(Uri.parse('$baseUrl/todos/$id/uncomplete'));

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to mark todo as incomplete (status ${response.statusCode})');
    }
  }

  Future<List<SensorModel>> getSensors() async {
    final r =
        await http.get(Uri.parse('$baseUrl/sensors')); // call FastAPI endpoint
    if (r.statusCode != 200) {
      throw Exception(
          'FastAPI error: ${r.statusCode} ${r.body}'); // Handle error
    }
    final list = (jsonDecode(r.body) as List)
        .cast<Map<String, dynamic>>(); //decode JSON sensor data
    return list.map((e) => SensorModel.fromJson(e)).toList(); // return as list
  }
}
