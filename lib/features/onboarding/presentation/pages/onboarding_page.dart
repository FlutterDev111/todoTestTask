import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todotask/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:todotask/features/onboarding/presentation/widgets/onboarding_content.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.pages.length,
            itemBuilder: (context, index) {
              final page = controller.pages[index];
              return OnboardingContent(
                image: page.image,
                title: page.title,
                description: page.description,
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Column(
              children: [
                Center(
                  child: SmoothPageIndicator(
                    controller: controller.pageController,
                    count: controller.pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Theme.of(context).colorScheme.primary,
                      dotColor: Colors.grey.shade300,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => TextButton(
                            onPressed: controller.currentPage.value < controller.pages.length - 1
                                ? controller.skip
                                : null,
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: controller.currentPage.value < controller.pages.length - 1
                                    ? Colors.grey
                                    : Colors.transparent,
                              ),
                            ),
                          )),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: IconButton(
                          onPressed: controller.nextPage,
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 