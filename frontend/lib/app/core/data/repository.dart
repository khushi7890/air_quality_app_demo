import 'package:air_quality_app_demo/app/core/data/services/service_fastapi.dart';
import 'package:air_quality_app_demo/app/core/data/services/service_firestore.dart';
import 'package:air_quality_app_demo/app/core/models/sensor_data.dart';
import 'package:air_quality_app_demo/app/core/models/todo_item.dart';

/// Repository class that acts as a unified data access layer for the app.
///
/// Coordinates between FastAPI backend (remote)and Firestore (cloud database)
/// to provide data to the rest of the application.
class Repository {
  /// FastAPI instance used to communicate with the backend API.
  final ServiceFastAPI fastAPI;

  /// Firestore instance used to communicate with the Firestore database.
  final ServiceFirestore firestore;

  /// Creates a [Repository] that requires both a [ServiceFastAPI] and a [ServiceFirestore].
  Repository({required this.fastAPI, required this.firestore});

  /// Fetches a list of to-do items from the FastAPI backend.
  ///
  /// Returns a [Future] that completes with a list of [TodoItem] objects.
  ///
  /// Throws an exception if the FastAPI service fails or returns invalid data.
  Future<List<TodoItem>> fetchTodos() async {
    // send to the fastAPI service to fetch todos
    return await fastAPI.getTodos();
  }

  /// Fetches a list of sensor readings from the FastAPI backend.
  ///
  /// Returns a [Future] containing a list of [SensorModel] objects,
  /// each representing an environmental sensor and its most recent data.
  ///
  /// May throw if the FastAPI endpoint is unreachable or returns malformed data.
  Future<List<SensorModel>> fetchSensors() => fastAPI.getSensors();

  /// Adds a demo sensor document to Firestore for testing purposes.
  ///
  /// This function doesn’t return anything, but it will write to the Firestore
  /// collection configured in [ServiceFirestore]. It’s commonly used for seeding
  /// example data or verifying Firestore connectivity
  Future<void> addDemoSensorToFirestore() async {
    await firestore.addDemoSensor();
  }
}
