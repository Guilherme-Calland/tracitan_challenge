enum ComponentStatus {
  alert, operating
}

extension ComponentStatusExtension on ComponentStatus{
  String get label {
    switch (this) {
      case ComponentStatus.alert:
        return 'Crítico';
      case ComponentStatus.operating:
        return 'Sensor de energia';
    }
  }
}