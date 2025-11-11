import 'package:air_quality_app_demo/app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_quality_app_demo/app/core/modules/home/home_controller.dart';
import 'package:air_quality_app_demo/app/core/widgets/aqi_wheel.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home - Firestore Demo')),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator();
          }

          if (controller.sensors.isEmpty) {
            return const Text(
              'No sensors found.',
              textAlign: TextAlign.center,
            );
          }

          final sensor = controller.sensors.first;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Device: ${sensor.deviceId}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              AQIWheel(aqi: sensor.aqi),
              const SizedBox(height: 16),
              Text(
                'AQI: ${sensor.aqi?.toStringAsFixed(1) ?? 'N/A'}',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text('Location: ${sensor.location}'),
              Text('Timestamp: ${sensor.timestamp}'),
            ],
          );
        }),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'refresh', // unique hero tag to avoid animation conflicts
            onPressed: controller.fetchDemoSensor,
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'todo',
            onPressed: () => Get.toNamed(Routes.todo),
            child: const Icon(Icons.list_alt),
          ),
        ],
      ),
    );
  }
}
