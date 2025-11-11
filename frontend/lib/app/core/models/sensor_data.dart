// class SensorModel {
//   final String? deviceId;
//   final double? aqi;
//   final String? location;
//   final String? timestamp;

//   SensorModel({this.deviceId, this.aqi, this.location, this.timestamp});

//   factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
//         deviceId: json['deviceId']?.toString(),
//         aqi: json['AQI'] is num ? (json['AQI'] as num).toDouble() : null,
//         location: json['location']?.toString(),
//         timestamp: json['timestamp']?.toString(),
//       );

//   Map<String, dynamic> toJson() => {
//         'deviceId': deviceId,
//         'AQI': aqi,
//         'location': location,
//         'timestamp': timestamp,
//       };
// }
/// A model representing one environmental sensor reading.
///
/// Can be built from either Firestore documents or FastAPI JSON.
/// Each sensor includes its unique device ID, AQI reading, location,
/// and a timestamp string in ISO 8601 format.
class SensorModel {
  /// Unique ID for the device (e.g., "PA100865")
  final String? deviceId;

  /// Air Quality Index value for this reading.
  final double? aqi;

  /// Describes where the sensor is located (e.g., "indoor", "outdoor").
  final String? location;

  /// UTC timestamp in ISO-8601 format.
  final String? timestamp;

  /// Creates a new [SensorModel] instance.
  SensorModel({
    this.deviceId,
    this.aqi,
    this.location,
    this.timestamp,
  });

  /// Factory constructor that safely parses a JSON map into a [SensorModel].
  ///
  /// Handles both Firestore and FastAPI response formats.
  /// Ensures all fields are converted to the correct type.
  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        deviceId: json['deviceId']?.toString(),
        aqi: json['AQI'] is num
            ? (json['AQI'] as num).toDouble()
            : double.tryParse(json['AQI']?.toString() ?? ''),
        location: json['location']?.toString(),
        timestamp: json['timestamp']?.toString(),
      );

  /// Converts this model to a JSON map for storage or network transmission.
  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'AQI': aqi,
        'location': location,
        'timestamp': timestamp,
      };

  /// Convenience factory for Firestore documents.
  ///
  /// Converts a Firestore [DocumentSnapshot] into a [SensorModel].
  /// Useful when using `.get()` or `.snapshots()` directly.
  factory SensorModel.fromFirestore(
      Map<String, dynamic>? data, String documentId) {
    if (data == null) return SensorModel();
    return SensorModel(
      deviceId: data['deviceId']?.toString() ?? documentId,
      aqi: data['AQI'] is num
          ? (data['AQI'] as num).toDouble()
          : double.tryParse(data['AQI']?.toString() ?? ''),
      location: data['location']?.toString(),
      timestamp: data['timestamp']?.toString(),
    );
  }

  /// Returns a human-readable string for debugging.
  @override
  String toString() =>
      'SensorModel(deviceId: $deviceId, aqi: $aqi, location: $location, timestamp: $timestamp)';
}
