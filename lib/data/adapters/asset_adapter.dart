import 'package:tracitan_challenge_development/core/constants/enums/component_status.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';

class AssetAdapter {
  Asset fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: (){
        String? status = json['status'];
        switch(status){
          case 'alert':
            return ComponentStatus.alert;
          case 'operating':
            return ComponentStatus.operating;
          default: 
            return null;
        }
      }(),
      gatewayId: json['gatewayId'],
      locationId: json['locationId'],
    );
  }
}
