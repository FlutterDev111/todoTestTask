import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int _selectedIndex = 0;
  String _selectedCategory = 'To-DO';
  bool _showAddOptions = false;
  String? selectedOption;

  int get selectedIndex => _selectedIndex;

  String get selectedCategory => _selectedCategory;

  bool get showAddOptions => _showAddOptions;


  void changeTab(int index) {
    _selectedIndex = index;
    notifyListeners();
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
    notifyListeners();
  }

  void changeCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleAddOptions() {
    _showAddOptions = !_showAddOptions;
    notifyListeners();
  }

  void hideAddOptions() {
    if (_showAddOptions) {
      _showAddOptions = false;
      notifyListeners();
    }
  }

  void selectOption(BuildContext context, String option) {
    selectedOption = option;
    _showAddOptions = false;
    notifyListeners();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _buildCustomBottomSheet(context),
    );
  }

  Widget _buildCustomBottomSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Orange Title Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFD86628),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  selectedOption ?? 'New Task',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // White Content Section
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          hintText: "eg : Meeting with client",
                          hintStyle: TextStyle(color: Color(0xFFADA4A5)),
                          border: InputBorder.none,
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(color: Color(0xFFADA4A5)),
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.calendar_today, color: Color(0xFFADA4A5)),
                          Icon(Icons.access_time, color: Color(0xFFADA4A5)),
                          Icon(Icons.flag, color: Color(0xFFADA4A5)),
                          Spacer(),
                          Icon(Icons.send, color: Color(0xFFD86628)),
                        ],
                      ),
                      const Divider(height: 30),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("🙂"), Text("💰"), Text("😇"), Text("🥰"),
                          Text("🙌"), Text("👋"), Text("😢"), Text("✌️"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  void showAddOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) =>
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
                  color: Theme
                      .of(context)
                      .primaryColor,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildOption(String text, VoidCallback onTap,
      {Color? color, Color? textColor}) {
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