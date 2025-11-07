import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceFirestore {
  final _db = FirebaseFirestore.instance;

  // DUMMY METHOD: Adds a demo sensor document to Firestore
  Future<void> addDemoSensor() async {
    final doc = _db.collection('sensors').doc('PA100865');
    await doc.set({
      'deviceId': 'PA100865',
      'AQI': 30.0,
      'location': 'outdoor',
      'timestamp': DateTime.now().toUtc().toIso8601String(),
    }, SetOptions(merge: true));
  }
}
