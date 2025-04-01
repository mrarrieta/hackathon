import 'package:ai_project/instance_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:home/tools/date_tools.dart';
import 'package:home/tools/record_validator.dart';
import 'package:home/views/home_page.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:login/views/login_page.dart';
import 'package:profile/views/profile_page.dart';
import 'package:signup/views/signup_screen.dart';
import 'package:splash/views/splash_page.dart';

class Routes {

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, __) => SplashPage(
            InstanceProvider.splashViewModel,
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
          loginViewModel: InstanceProvider.loginViewmodel,
          onSuccess: () => context.go('/home'),
          goToSignup: () => context.go('/signup'),
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, __) =>
            HomePage(
              recordRepository: InstanceProvider.recordRepository,
              recordValidatorProvider: RecordValidatorProvider(context.l10n, DateTools()),
              goToLogin: () => context.go('/login'),
              goToProfile: () => context.go('/profile'),
              startCaptureFlow: () => context.go('/capture'),
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