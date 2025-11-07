import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sensor_data.dart';
import '../models/todo_item.dart';

class ServiceFastAPI {
  final String baseUrl;
  ServiceFastAPI({required this.baseUrl}); // constructor, sets baseURl

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
      throw Exception('Failed to load todos');
    }
  }

  Future<List<SensorModel>> getSensors() async {
    final r = await http.get(Uri.parse('$baseUrl/sensors'));
    if (r.statusCode != 200) {
      throw Exception('FastAPI error: ${r.statusCode} ${r.body}');
    }
    final list = (jsonDecode(r.body) as List).cast<Map<String, dynamic>>();
    return list.map((e) => SensorModel.fromJson(e)).toList();
  }
}
