import 'package:get/get.dart';
import 'package:air_quality_app_demo/app/core/data/repository.dart';
import 'package:air_quality_app_demo/app/core/models/sensor_data.dart';

class HomeController extends GetxController {
  final Repository repository;

  HomeController(this.repository);

  // Reactive variables
  var sensors = <SensorModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDemoSensor();
  }

  /// Fetches the demo sensor data from Firestore
  Future<void> fetchDemoSensor() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchSensors();
      sensors.assignAll(result);
    } catch (e) {
      print('Error fetching sensors: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Gets the first sensor's AQI, or 0 if none exist
  double get currentAQI =>
      sensors.isNotEmpty ? (sensors.first.aqi ?? 0.0) : 0.0;
}
