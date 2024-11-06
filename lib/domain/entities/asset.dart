import 'package:tracitan_challenge_development/core/constants/enums/component_status.dart';
import 'package:tracitan_challenge_development/domain/entities/company_item.dart';

class Asset extends CompanyItem{
  final String? sensorId;
  final String? sensorType;
  final ComponentStatus? status;
  final String? gatewayId;
  final String? locationId;

  Asset({
    required super.id,
    required super.name,
    required super.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    required this.locationId,
  });
}