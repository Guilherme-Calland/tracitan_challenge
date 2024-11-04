import 'package:tracitan_challenge_development/domain/entities/location.dart';

class LocationAdapter{
  Location fromJson(Map<String, dynamic> json){
    return Location(id: json['id'], name: json['name'], parentId: json['parentId']);
  }
}