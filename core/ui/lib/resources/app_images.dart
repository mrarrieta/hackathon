class AppImages {
  static const logo = AppAssetImage('logo.svg');
  static const logoJpg = AppAssetImage('logo.jpg');
  static const loading = AppAssetImage('loading.gif');
}

class AppAssetImage {
  final String filename;

  const AppAssetImage(this.filename);

  /// Returns a complete path to be called from an external module where ui was imported.
  /// Requires that ui package was imported with the id 'ui' in the external module's pubspec.yaml
  String get path => 'core/ui/assets/images/$filename';
}
