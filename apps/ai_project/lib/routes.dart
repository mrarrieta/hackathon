import 'package:ai_project/instance_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home/tools/date_tools.dart';
import 'package:home/tools/record_validator.dart';
import 'package:home/views/home_page.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:login/data/login_api.dart';
import 'package:login/views/login_page.dart';
import 'package:profile/data/profile_model.dart';
import 'package:profile/views/profile_page.dart';
import 'package:signup/views/signup_page.dart';
import 'package:splash/views/splash_page.dart';

class Routes {

  static LoginResponse? loginResponse;

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, __) => NoTransitionPage(
            child: SplashPage(
                InstanceProvider.splashClient,
                () => context.replace('/login')
            )
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, __) => NoTransitionPage(
          child: SignupPage(
                  goToLogin: () => context.go('/login'),
                  onSuccess: () => context.go('/login'),
                  signupViewModel: InstanceProvider.signupViewModel,
          ),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, __) => NoTransitionPage(
          child: LoginPage(
            loginClient: InstanceProvider.loginClient,
            onSuccess: (response) {
              loginResponse = response;
              context.go('/home');
            },
            goToSignup: () => context.go('/signup'),
          ),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, __) => NoTransitionPage(
          child: HomePage(
            recordRepository: InstanceProvider.recordRepository,
            recordValidatorProvider: RecordValidatorProvider(context.l10n, DateTools()),
            goToLogin: () => context.go('/login'),
            goToProfile: () => context.go('/profile'),
          ),
        ),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, __) => NoTransitionPage(
          child: ProfilePage(
            profileModel: ProfileModel(
                name: loginResponse?.name ?? "",
                lastname: loginResponse?.lastname ?? "",
                description: loginResponse?.description ?? "",
                birthDate: loginResponse?.birthdate ?? "",
                imageBase64: loginResponse?.image
                    ?.replaceAll("\n", "").replaceAll(" ", "") ?? "",
            ),
            goToLogin: () => context.go('/login'),
            goToHome: () => context.go('/home'),
          ),
        ),
      ),
    ],
  );
}