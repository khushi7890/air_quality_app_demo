class SensorModel {
  final String? deviceId;
  final double? aqi;
  final String? location;
  final String? timestamp;

  SensorModel({this.deviceId, this.aqi, this.location, this.timestamp});

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        deviceId: json['deviceId']?.toString(),
        aqi: json['AQI'] is num ? (json['AQI'] as num).toDouble() : null,
        location: json['location']?.toString(),
        timestamp: json['timestamp']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'AQI': aqi,
        'location': location,
        'timestamp': timestamp,
      };
}
