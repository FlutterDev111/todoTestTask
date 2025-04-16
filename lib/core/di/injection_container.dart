import 'package:get/get.dart';
import 'package:todotask/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:todotask/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:todotask/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:todotask/features/onboarding/domain/usecases/get_onboarding_pages.dart';
import 'package:todotask/features/onboarding/presentation/controllers/onboarding_controller.dart';

class DependencyInjection {
  static void init() {
    // Data sources
    Get.lazyPut<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(),
      fenix: true,
    );

    // Repositories
    Get.lazyPut<OnboardingRepository>(
      () => OnboardingRepositoryImpl(Get.find()),
      fenix: true,
    );

    // Use cases
    Get.lazyPut(
      () => GetOnboardingPages(Get.find()),
      fenix: true,
    );

    // Controllers
    Get.lazyPut(
      () => OnboardingController(Get.find()),
      fenix: true,
    );
  }
} 