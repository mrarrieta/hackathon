import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locale/l10n/core_localizations.dart';
import 'package:signup/data/signup_api.dart';

class SignupState {
  SignupState({
    this.isLoading = false,
    this.signupResponse,
    this.signupError,
  });

  final bool isLoading;
  final SignupResponse? signupResponse;
  final String? signupError;
}

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.signupClient, this.localization) : super(SignupState());

  final SignupClient signupClient;
  final CoreLocalizations localization;

  String? validateField(String? value) {
    return value?.isEmpty ?? true ? localization.required : null;
  }

  void signup(SignupResponse newUser) {
    emit(SignupState(isLoading: true));

    signupClient.createUser(newUser).then((_) {
      emit(SignupState(signupResponse: newUser));
    }).onError((_, __) {
      emit(SignupState(signupError: localization.signupError));
    });
  }
}
