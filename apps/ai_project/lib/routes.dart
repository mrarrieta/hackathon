import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:home/views/home_page.dart';
import 'package:login/data/login_api.dart';
import 'package:login/data/login_view_model.dart';
import 'package:login/views/login_page.dart';
import 'package:profile/views/profile_page.dart';
import 'package:signup/views/signup_screen.dart';
import 'package:splash/data/splash_api.dart';
import 'package:splash/data/splash_view_model.dart';
import 'package:splash/views/splash_page.dart';

class Routes {

  static Dio _dio = Dio(BaseOptions(contentType: "application/json"));
  static LoginClient _loginClient = LoginClient(_dio);
  static SplashClient _splashClient = SplashClient(_dio);
  static LoginViewModel _loginViewmodel = LoginViewModel(_loginClient);
  static SplashViewModel _splashViewModel = SplashViewModel(_splashClient);

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, __) => SplashPage(
            _splashViewModel,
                () => context.replace('/login')
        ),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, __) =>
            SignupScreen(
                  () => context.go('/login')
            ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, __) => LoginPage(
          loginViewModel: _loginViewmodel,
          onSuccess: () => context.go('/home'),
          goToSignup: () => context.go('/signup'),
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, __) =>
            HomePage(
                  () => context.go('/login'),
                  () => context.go('/profile'),
            ),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, __) =>
            ProfilePage(
                  () => context.go('/login'),
                  () => context.go('/home'),
            ),
      ),
    ],
  );
}