import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/constants/enums/component_status.dart';
import 'package:tracitan_challenge_development/domain/entities/company_item.dart';
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
    _items.clear();
    _status = null;
  }

  final List<CompanyItem> _items = [];
  List<CompanyItem> get items => _items;

  ComponentStatus? _status;
  ComponentStatus? get status => _status;

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
      _items.addAll(assetSuccess);
    });
  }

  Future<void> _getLocations(String companyId) async{
    final result = await getLocationsUsecase(companyId);
    result.fold((e){
      debugPrint('$e');
      _error = true;
    }, (locationsSuccess){
      _items.addAll(locationsSuccess);
    });
  }

  void changeStatus(ComponentStatus s){
    bool alreadySelected = s == _status;
    if(alreadySelected){
      _status = null;
    }else{
      _status = s;
    }

    notifyListeners();
  }
}