import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;
  final selectedCategory = 'To-DO'.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  void showAddOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption(
              'Setup Journal',
              () => Get.back(),
            ),
            const SizedBox(height: 16),
            _buildOption(
              'Setup Habit',
              () => Get.back(),
            ),
            const SizedBox(height: 16),
            _buildOption(
              'Add List',
              () => Get.back(),
            ),
            const SizedBox(height: 16),
            _buildOption(
              'Add Note',
              () => Get.back(),
            ),
            const SizedBox(height: 16),
            _buildOption(
              'Add Todo',
              () => Get.back(),
              color: Theme.of(Get.context!).primaryColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String text, VoidCallback onTap, {Color? color, Color? textColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: color == null ? Border.all(color: Colors.grey[300]!) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor ?? const Color(0xFF1D1517),
            ),
          ),
        ),
      ),
    );
  }
} 