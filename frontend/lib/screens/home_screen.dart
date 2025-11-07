import 'package:flutter/material.dart';
import 'package:air_quality_app_demo/models//aqi_wheel.dart'; // adjust the import

class HomeScreen extends StatelessWidget {
  // dummy sensor data to help build AQI wheel
  // should get rid of soon
  final Map<String, dynamic> sensorData = {
    'timestamp': '2025-11-04T21:10:54.191488+00:00',
    'deviceId': 'PA100025',
    'AQI': 212.0,
    'AQI_dominant_pollutant': 'pm2.5'
  };

  // Basic alignment and put in AQUI wheel
  @override
  Widget build(BuildContext context) {
    final aqi = sensorData['AQI'];
    return Scaffold(
      appBar: AppBar(title: const Text('Air Quality Sensor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AQIWheel(aqi: aqi),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
