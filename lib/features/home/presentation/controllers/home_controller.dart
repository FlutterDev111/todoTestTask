import 'package:flutter/material.dart';

import '../widgets/add_options_sheet.dart';
import '../widgets/bottom_sheets/custom_task_sheet.dart';


class HomeController extends ChangeNotifier {
  int _selectedIndex = 0;
  String _selectedCategory = 'To-DO';
  bool _showAddOptions = false;
  String? selectedOption;
  GlobalKey flagKey = GlobalKey();
  String? selectedPriority;
  String? _selectedIcon;
  DateTime? _selectedDate;
  bool _is12HourFormat = true;
  DateTime _focusedDate = DateTime.now();
  DateTime _tempSelectedDate = DateTime.now();
  String _selectedTime = '10:30 AM';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int get selectedIndex => _selectedIndex;
  String? get selectedIcon => _selectedIcon;
  String get selectedCategory => _selectedCategory;
  bool get showAddOptions => _showAddOptions;
  DateTime? get selectedDate => _selectedDate;
  bool get is12HourFormat => _is12HourFormat;
  DateTime get focusedDate => _focusedDate;
  DateTime get tempSelectedDate => _tempSelectedDate;
  String get selectedTime => _selectedTime;

  void changeTab(int index) {
    _selectedIndex = index;
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
      builder: (_) => CustomTaskSheet(selectedOption: selectedOption),
    );
  }

  void selectIcon(String iconName) {
    _selectedIcon = iconName;
    notifyListeners();
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _selectedDate = picked;
      selectIcon('calendar');
      notifyListeners();
    }
  }

  void toggleFormat(bool is12Hour) {
    _is12HourFormat = is12Hour;
    notifyListeners();
  }

  void updateTempSelectedDate(DateTime date, DateTime focus) {
    _tempSelectedDate = date;
    _focusedDate = focus;
    notifyListeners();
  }

  void confirmSelectedDate() {
    _selectedDate = _tempSelectedDate;
    notifyListeners();
  }

  void updateSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void showAddOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const AddOptionsSheet(),
    );
  }

  void showPriorityMenu(BuildContext context) {
    showPriorityMenu(context);
  }

  void showDueDatePicker(BuildContext context) {
    showDueDatePicker(context);
  }

  void showTimePickerSheet(BuildContext context) {
    showTimePickerSheet(context);
  }
}
