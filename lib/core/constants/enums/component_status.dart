import 'package:tracitan_challenge_development/core/constants/image_paths.dart';

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

  String get iconPath {
    switch (this) {
      case ComponentStatus.alert:
        return ImagePaths.warning;
      case ComponentStatus.operating:
        return ImagePaths.boltHollow;
    }
  }
}