import 'package:get/get.dart';
import 'package:todotask/core/routes/app_routes.dart';
import 'package:todotask/features/auth/presentation/pages/login_page.dart';
import 'package:todotask/features/auth/presentation/pages/signup_page.dart';
import 'package:todotask/features/onboarding/presentation/bindings/onboarding_binding.dart';
import 'package:todotask/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:todotask/features/splash/presentation/bindings/splash_binding.dart';
import 'package:todotask/features/splash/presentation/pages/splash_page.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController());
      }),
    ),
    // Add more routes here
  ];
} 