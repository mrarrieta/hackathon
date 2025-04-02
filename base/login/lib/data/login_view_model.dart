import 'package:locale/l10n/core_localizations.dart';
import 'package:login/data/login_api.dart';

class LoginViewModel {
  LoginViewModel(this.loginClient);

  final LoginClient loginClient;

  LoginResponse? response;

  Future<String?> login(CoreLocalizations localization, String user, String pass) async {
    final response = await loginClient.getUser(user);
    if (response == null) return localization.noUserError;
    if (response.password == pass) {
      this.response = response;
      return null;
    } else {
      return localization.wrongPasswordError;
    }
  }
}
