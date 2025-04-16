import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todotask/controllers/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: const [
              OnboardingPage(
                image: 'assets/img/onboarding1.png',
                title: '🎯 Stay Organized & Focused',
                description: 'Easily create, manage, and prioritize your tasks to stay on top of your day.',
              ),
              OnboardingPage(
                image: 'assets/img/onboarding2.png',
                title: '⌛ Never Miss a Deadline',
                description: 'Set reminders and due dates to keep track of important tasks effortlessly.',
              ),
              OnboardingPage(
                image: 'assets/img/onboarding3.png',
                title: '✅ Boost Productivity',
                description: 'Break tasks into steps, track progress, and get more done with ease.',
              ),
            ],
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
                    count: 3,
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
                            onPressed: controller.currentPage.value < 2
                                ? controller.skip
                                : null,
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: controller.currentPage.value < 2
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

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 300,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 