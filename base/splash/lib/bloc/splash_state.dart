
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash/data/splash_api.dart';

class SplashState {
  SplashState({
    required this.isLoading,
    required this.isSuccess,
    this.message,
    this.image,
    this.error,
  });

  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final String? message;
  final String? image;
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.splashClient) : super(SplashState(isLoading: true, isSuccess: false));

  final SplashClient splashClient;

  void getSplashData() {
    splashClient.getSplash("light")
        .then((response) {
          if (response == null) {
            emit(
                SplashState(
                    isLoading: true,
                    error: "null response",
                    isSuccess: false
                )
            );
            return;
          } else {
            emit(
                SplashState(
                    isLoading: false,
                    error: null,
                    isSuccess: true,
                    message: response.randomSentence,
                    image: response.image
                )
            );
            return;
          }
        }).onError((_, error) {
          emit(SplashState(
              isLoading: true, error: error.toString(), isSuccess: false));
        });
  }
}