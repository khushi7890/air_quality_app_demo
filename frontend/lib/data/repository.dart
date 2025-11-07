import 'package:air_quality_app_demo/models/todo_item.dart';

import 'service_fastapi.dart';
import 'service_firestore.dart';
import '../models/sensor_data.dart';

class Repository {
  final ServiceFastAPI fastAPI;
  final ServiceFirestore? firestore;

  Repository({required this.fastAPI, required this.firestore});

  Future<List<TodoItem>> fetchTodos() async{
    // send to the fastAPI service to fetch todos
    return await fastAPI.fetchTodos();
  }
  Future<List<SensorModel>> fetchSensors() => fastAPI.getSensors();

  // Future<void> addDemoSensorToFirestore() async {
  //   await firestore.addDemoSensor();
  // }
}
