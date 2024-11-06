import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/constants/enums/component_status.dart';

class StatusProvider extends ChangeNotifier{
  ComponentStatus? _status;
  ComponentStatus? get status => _status;

  void changeStatus(ComponentStatus s){
    bool alreadySelected = s == _status;
    if(alreadySelected){
      _status = null;
    }else{
      _status = s;
    }

    notifyListeners();
  }

  void clear(){
    _status = null;
  }
}