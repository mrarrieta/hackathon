import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:locale/l10n/core_localizations.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:login/data/login_api.dart';

import 'login_service.dart';

class LoginViewModel {
  LoginViewModel(this.loginClient);

  final LoginClient loginClient;

  String name = '';
  String password = '';
  LoginResponse? response;

  Future<String?> login(CoreLocalizations localization) async {
    final response = await loginClient.getUser(name);
    if (response == null) return localization.noUserError;
    if (response.password == password) {
      this.response = response;
      return null;
    } else {
      return localization.wrongPasswordError;
    }
  }
}
