import 'package:flutter/material.dart';
import 'package:todotask/core/routes/app_routes.dart';
import 'package:todotask/features/auth/presentation/pages/login_page.dart';
import 'package:todotask/features/auth/presentation/pages/signup_page.dart';
import 'package:todotask/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:todotask/features/splash/presentation/pages/splash_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';

class AppPages {
  static const initial = AppRoutes.login;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => SignupPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
} 