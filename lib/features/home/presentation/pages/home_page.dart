import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import '../widgets/category_chip.dart';
import '../widgets/empty_tasks.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('EEE dd MMMM yyyy').format(DateTime.now()),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search task',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(
                      label: 'To-DO',
                      isSelected: controller.selectedCategory == 'To-DO',
                      onTap: () => controller.changeCategory('To-DO'),
                    ),
                    CategoryChip(
                      label: 'Habit',
                      isSelected: controller.selectedCategory == 'Habit',
                      onTap: () => controller.changeCategory('Habit'),
                    ),
                    CategoryChip(
                      label: 'Journal',
                      isSelected: controller.selectedCategory == 'Journal',
                      onTap: () => controller.changeCategory('Journal'),
                    ),
                    CategoryChip(
                      label: 'Note',
                      isSelected: controller.selectedCategory == 'Note',
                      onTap: () => controller.changeCategory('Note'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: EmptyTasks(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.showAddOptions(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
} 