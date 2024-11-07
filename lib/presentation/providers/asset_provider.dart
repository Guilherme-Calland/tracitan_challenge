import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/constants/enums/component_status.dart';
import 'package:tracitan_challenge_development/domain/entities/asset.dart';
import 'package:tracitan_challenge_development/domain/entities/company_item.dart';
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

  bool _emptyList = false;
  bool get emptyList => _emptyList;
  
  void clear(){
    _loading = true;
    _error = false;
    _items.clear();
    _allItems.clear();
    _status = null;
    _emptyList = false;
    _searchController.clear();
  }

  final List<CompanyItem> _items = [];
  List<CompanyItem> get items => _items;

  final List<CompanyItem> _allItems = [];
  ComponentStatus? _status;
  ComponentStatus? get status => _status;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  Future<void> loadData(String companyId) async{
    final futureLoadList = [
      _getLocations(companyId),
      _getAssets(companyId)
    ];
    await Future.wait(futureLoadList);

    _putLocationsFirst();
    _allItems.addAll(_items);

    _loading = false;
    notifyListeners();
  }

  void _putLocationsFirst() {
    final List<Location> locations = _items.whereType<Location>().toList();
    final List<Asset> assets = _items.whereType<Asset>().toList();
    _items.clear();
    _items.addAll(locations);
    _items.addAll(assets);
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
    _searchController.clear();

    bool alreadySelected = s == _status;
    if(alreadySelected){
      _status = null;
    }else{
      _status = s;
    }

    _items.clear();
    if(_status != null){
      for (var item in _allItems) {
        if(item is Asset){
          bool isComponent = item.sensorType != null;
          if((item.status == _status) && isComponent){
            _items.add(item);
          }
        }
      }
      _addParents();
      _putLocationsFirst();

    }else{
      _items.addAll(_allItems);
    }

    _emptyList = _items.isEmpty;

    notifyListeners();
  }

  void _addParents() {
    final List<CompanyItem> newParentItems = [];
    newParentItems.addAll(_items);
    do {
      List<CompanyItem> tempList = [];
      
      final idsToRemove = _items.map((item) => item.id).toSet();

      final List<CompanyItem> remainingItems = [];
      remainingItems.addAll(_allItems);
      remainingItems.removeWhere((item) => idsToRemove.contains(item.id));

      for(var item in remainingItems){
        bool itemHasSavedParent = newParentItems.any((i){
          if(i is Asset){
            return i.parentId == item.id || i.locationId == item.id;
          }else{
            return i.parentId == item.id;
          }
        });
        if(itemHasSavedParent) {
          tempList.add(item);
        }
      }
    
      newParentItems.clear();
      newParentItems.addAll(tempList);
      _items.addAll(tempList);
    } while (newParentItems.isNotEmpty);
  }

  void searchItem(String query) {
    _status = null;
    _items.clear();

    for (var item in _allItems) {
      bool nameContainsQuery =  RegExp(query, caseSensitive: false).hasMatch(item.name);
      if(nameContainsQuery){
        _items.add(item);
      }
    }

    final List<CompanyItem> currentItems = [];
    currentItems.addAll(_items);
    _items.removeWhere((i){
      bool hasChildren = currentItems.any((j){
        if(j is Asset){
          return j.parentId == i.id || j.locationId == i.id;
        }else{
          return j.parentId == i.id;
        }
      });
      return hasChildren;
    });

    _emptyList = _items.isEmpty;
    if(!_emptyList){
      _addParents();
      _putLocationsFirst();
    }

    notifyListeners();
  }
}