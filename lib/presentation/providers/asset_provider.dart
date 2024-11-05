import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/entities/location.dart';
import 'package:tracitan_challenge_development/domain/usecases/get_assets_usecase.dart';
import 'package:tracitan_challenge_development/domain/usecases/get_locations_usecase.dart';

class AssetProvider extends ChangeNotifier{
  final GetAssetsUsecase getAssetsUsecase;
  final GetLocationsUsecase getLocationsUsecase;

  AssetProvider({
    required this.getAssetsUsecase,
    required this.getLocationsUsecase,
  });

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

  Future<void> loadData(String companyId) async{
    _error = false;
    _loading = true;
    notifyListeners();

    final futureLoadList = [
      _getAssets(companyId),
      _getLocations(companyId)
    ];
    await Future.wait(futureLoadList);

    _loading = false;
    notifyListeners();
  }
  
  Future<void> _getAssets(String companyId) async{
    final result = await getAssetsUsecase(companyId);
    result.fold((e){
      debugPrint('$e');
      _error = true;
    }, (assetSuccess){
      _assets.addAll(assetSuccess);
    });
  }

  Future<void> _getLocations(String companyId) async{
    final result = await getLocationsUsecase(companyId);
    result.fold((e){
      debugPrint('$e');
      _error = true;
    }, (locationsSuccess){
      _locations.addAll(locationsSuccess);
    });
  }
}