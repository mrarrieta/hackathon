import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locale/l10n/core_localizations.dart';
import 'package:login/data/login_api.dart';

class LoginState {
  LoginState({
    this.isLoading = false,
    this.loginResponse,
    this.loginError,
  });

  final bool isLoading;
  final LoginResponse? loginResponse;
  final String? loginError;
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginClient, this.localization) : super(LoginState());

  final LoginClient loginClient;
  final CoreLocalizations localization;

  String? validateField(String? value) {
    return value?.isEmpty ?? true ? localization.required : null;
  }

  void login(String user, String pass) {
    loginClient.getUser(user).then((response) {
      if (response == null) {
        emit(LoginState(loginError: localization.noUserError));
        return;
      } else if (response.password == pass) {
        emit(LoginState(loginResponse: response));
        return;
      } else {
        emit(LoginState(loginError: localization.wrongPasswordError));
        return;
      }
    }).onError((_, error) {
      emit(LoginState(loginError: localization.loginError));
    });
  }
}