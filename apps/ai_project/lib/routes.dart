import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:home/views/home_page.dart';
import 'package:login/data/login_api.dart';
import 'package:login/data/login_view_model.dart';
import 'package:login/views/login_page.dart';
import 'package:profile/views/profile_page.dart';
import 'package:signup/views/signup_screen.dart';
import 'package:splash/views/splash_screen.dart';

class Routes {

  static Dio _dio = Dio(BaseOptions(contentType: "application/json"));
  static LoginClient _loginClient = LoginClient(_dio);
  static LoginViewModel _loginViewmodel = LoginViewModel(_loginClient);

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, __) => SplashScreen(() => context.replace('/login')),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, __) =>
            SignupScreen(
                  () => context.go('/login'),
                  () => context.go('/home'),
                  () => context.go('/profile'),
            ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, __) =>
            LoginPage(
              _loginViewmodel,
                  () => context.go('/home'),
            ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, __) =>
            HomePage(
                  () => context.go('/login'),
                  () => context.go('/signup'),
                  () => context.go('/profile'),
            ),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, __) =>
            ProfilePage(
                  () => context.go('/login'),
                  () => context.go('/signup'),
                  () => context.go('/home'),
            ),
      ),
    ],
  );
}