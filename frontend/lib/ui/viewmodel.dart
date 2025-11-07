import 'package:flutter/foundation.dart';
import '../data/repository.dart';
import '../models/sensor_data.dart';

class SensorViewModel extends ChangeNotifier {
  final Repository repository;
  bool loading = false;
  List<SensorModel> sensors = [];

  SensorViewModel(this.repository);

  Future<void> loadSensors() async {
    loading = true;
    notifyListeners(); // indicate while loading is happening
    try {
      sensors = await repository.fetchSensors(); // via FastAPI
    } finally {
      loading = false;
      notifyListeners(); // indicate loading is done
    }
  }

  Future<void> addDemoSensor() async {
    //await repository.addDemoSensorToFirestore();
    await loadSensors();
  }
}
