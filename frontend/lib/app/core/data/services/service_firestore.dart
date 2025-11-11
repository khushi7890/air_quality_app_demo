import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore service layer that provides helper methods
/// for interacting with the Firebase Cloud Firestore database.
class ServiceFirestore {
  /// single Firestore database instance.
  ///
  /// All read/write operations are performed through this handle.
  final database = FirebaseFirestore.instance;

  // DUMMY METHOD: Adds a demo sensor document to Firestore
  Future<void> addDemoSensor() async {
    final doc = database.collection('sensors').doc('PA100865');
    await doc.set({
      'deviceId': 'PA100865',
      'AQI': 30.0,
      'location': 'outdoor',
      'timestamp': DateTime.now().toUtc().toIso8601String(),
    }, SetOptions(merge: true));
  }
}
