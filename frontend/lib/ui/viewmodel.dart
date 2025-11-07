import 'package:flutter/foundation.dart';
import '../data/repository_a.dart';
import '../models/sensor_data.dart';

class SensorViewModel extends ChangeNotifier {
  final RepositoryA repository;
  bool loading = false;
  List<SensorModel> sensors = [];

  SensorViewModel(this.repository);

  Future<void> loadSensors() async {
    loading = true; notifyListeners();
    try {
      sensors = await repository.fetchSensors(); // via FastAPI
    } finally {
      loading = false; notifyListeners();
    }
  }

  Future<void> addDemoSensor() async {
    await repository.addDemoSensorToFirestore();
    await loadSensors();
  }
}
