import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';

class AssetProvider extends ChangeNotifier{
  bool _loading = true;
  bool get loading => _loading;
  
  bool _error = false;
  bool get error => _error;
  
  void clear(){
    _loading = true;
    _error = false;
    _locations.clear();
    _assets.clear();
  }

  final List<Location> _locations = [];
  List<Location> get locations => _locations;

  final List<Asset> _assets = [];
  List<Asset> get assets => _assets;
}