class ImagePaths {
  static String locationIcon = _buildPath("location");
  static String assetIcon = _buildPath("asset");
  static String componentIcon = _buildPath("component");
  static String alertStatusIcon = _buildPath("dot");
  static String operationStatusIcon = _buildPath("bolt");
  static String logo = _buildPath("logo");
  static String blocks = _buildPath("blocks");
  static String boltHollow = _buildPath("bolt_hollow");
  static String warning = _buildPath("warning");

  static String _buildPath(String key) {
    return 'assets/$key.png';
  }
}
