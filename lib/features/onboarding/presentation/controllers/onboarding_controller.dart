import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todotask/core/routes/app_routes.dart';
import 'package:todotask/features/onboarding/domain/entities/onboarding_page.dart';
import 'package:todotask/features/onboarding/domain/usecases/get_onboarding_pages.dart';

class OnboardingController extends GetxController {
  final GetOnboardingPages _getOnboardingPages;
  
  OnboardingController(this._getOnboardingPages);

  final pageController = PageController();
  final currentPage = 0.obs;
  late final List<OnboardingPageEntity> pages;

  @override
  void onInit() {
    super.onInit();
    pages = _getOnboardingPages();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login screen
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void skip() {
    pageController.animateToPage(
      pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
} 