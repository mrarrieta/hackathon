import 'package:locale/l10n/core_localizations.dart';
import 'package:signup/data/signup_api.dart';

class SignupViewModel {
  SignupViewModel(this.signupClient);

  final SignupClient signupClient;

  SignupResponse? response;

  Future<String?> signup(CoreLocalizations localization, SignupResponse newUser) async {
    //final existing = await signupClient.getUser(newUser.name ?? "");
    //if (existing != null) return localization.userAlreadyExists;

    try {
      await signupClient.createUser(newUser);
      response = newUser;
      return null;
    } catch (_) {
      return localization.signupError;
    }
  }
}
