import 'package:flutter/material.dart';
import '../data/service_fastapi.dart';
import 'package:air_quality_app_demo/models//aqi_wheel.dart'; // adjust the import

class HomeScreen extends StatelessWidget {

  // dummy sensorData object for AQI display
  final Map<String, dynamic> sensorData = {
    'timestamp': '2025-11-04T21:10:54.191488+00:00',
    'deviceId': 'PA100025',
    'AQI': 150.0,
    'AQI_dominant_pollutant': 'pm2.5'
  };

  // displays our AQI Wheel widget
  @override
  Widget build(BuildContext context) {
    //get dummy data
    final aqi = sensorData['AQI'];
    return Scaffold(
      // title and basic alignment
      appBar: AppBar(title: const Text('Air Quality Sensor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // feed into constructor - AQI wheel is a separate dart object
            AQIWheel(aqi: aqi),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
