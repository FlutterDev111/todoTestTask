import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todotask/core/constants/app_constants.dart';
import 'package:todotask/features/splash/presentation/controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF8B60),  // Lighter orange at top
              Color(0xFFE17055),  // Base orange in middle
              Color(0xFFD35A3C),  // Darker orange at bottom
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1500),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: value,
                  child: Image.asset(
                    AppConstants.splash,
                    width: 250,  // Increased size for better visibility
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
} 