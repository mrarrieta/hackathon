import 'package:locale/l10n/core_localizations.dart';
import 'package:splash/data/splash_api.dart';

class SplashViewModel {
  SplashViewModel(this.splashClient);

  final SplashClient splashClient;

  SplashResponse? response;

  Future<SplashResponse?> getSplash() async {
    final response = await splashClient.getSplash("light");
    if (response == null) return null;
      this.response = response;
      return this.response;
  }
}
