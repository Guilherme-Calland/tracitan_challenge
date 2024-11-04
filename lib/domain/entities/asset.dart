class Asset{
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;

  Asset({required this.id, required this.name, required this.parentId, required this.sensorId, required this.sensorType, required this.status, required this.gatewayId, required this.locationId});
}