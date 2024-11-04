import 'package:tracitan_challenge_development/domain/entities/asset.dart';

class AssetAdapter {
  Asset fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
      gatewayId: json['gatewayId'],
      locationId: json['locationId'],
    );
  }
}
