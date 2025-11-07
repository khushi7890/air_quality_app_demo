import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel.dart';

class SensorListScreen extends StatefulWidget {
  const SensorListScreen({super.key});

  @override
  State<SensorListScreen> createState() => _SensorListScreenState();
}

class _SensorListScreenState extends State<SensorListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SensorViewModel>().loadSensors());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SensorViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Sensors (FastAPI + Firestore)')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: vm.sensors.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final s = vm.sensors[i];
                return ListTile(
                  title: Text('${s.deviceId} — AQI ${s.aqi ?? "-"}'),
                  subtitle: Text('Location: ${s.location ?? "unknown"} • ${s.timestamp ?? ""}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => vm.addDemoSensor(),
        label: const Text("Add demo to Firestore"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
