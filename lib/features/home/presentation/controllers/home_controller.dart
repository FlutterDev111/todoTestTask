import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int _selectedIndex = 0;
  String _selectedCategory = 'To-DO';

  int get selectedIndex => _selectedIndex;
  String get selectedCategory => _selectedCategory;

  void changeTab(int index) {
    _selectedIndex = index;
    notifyListeners();
    // Here you can add navigation logic for different tabs
    switch (index) {
      case 0: // Home
        break;
      case 1: // Notification
        break;
      case 2: // Calendar
        break;
      case 3: // Profile
        break;
    }
  }

  void changeCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => Container(
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
              () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            _buildOption(
              'Setup Habit',
              () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            _buildOption(
              'Add List',
              () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            _buildOption(
              'Add Note',
              () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
            _buildOption(
              'Add Todo',
              () => Navigator.pop(context),
              color: Theme.of(context).primaryColor,
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