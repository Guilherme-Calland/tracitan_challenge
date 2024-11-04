import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';

class LocationProvider extends ChangeNotifier{
  bool _loading = true;
  bool get loading => _loading;

  clear(){
    _loading = true;
    _locations.clear();
  }

  final List<Location> _locations = [];
  List<Location> get locations => _locations;

  
}