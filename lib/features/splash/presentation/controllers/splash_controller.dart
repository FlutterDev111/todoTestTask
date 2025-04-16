import 'package:get/get.dart';
import 'package:todotask/core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash screen duration
    Get.offAllNamed(AppRoutes.onboarding);
  }
} 