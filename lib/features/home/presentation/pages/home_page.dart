import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/task_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Today",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Mon 20 March 2024",
                    style: TextStyle(fontSize: 16, color: Color(0xff767E8C), fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 56,
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Color(0xffADA4A5)),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Task",
                              hintStyle: TextStyle(color: Color(0xffDDDADA)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      TaskTypeButton(text: "To-Do"),
                      const SizedBox(width: 10),
                      TaskTypeButton(text: "Habit"),
                      const SizedBox(width: 10),
                      TaskTypeButton(text: "Journal"),
                      const SizedBox(width: 10),
                      TaskTypeButton(text: "Note"),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/img/filter.png",
                          height: 25,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Image.asset(
                    "assets/img/hooray.png",
                    height: 280,
                    fit: BoxFit.fill,
                  ),
                  const Spacer(),
                ],
              ),
            ),

            if (homeProvider.showAddOptions)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 0.6,
                child: GestureDetector(
                  onTap: () => homeProvider.hideAddOptions(),
                  child: Container(
                    color: Colors.white70,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),

            // Floating menu options
            if (homeProvider.showAddOptions)
              Positioned(
                bottom: 100,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildOptionButton(context, homeProvider, "Setup Journal"),
                    _buildOptionButton(context, homeProvider, "Setup Habit"),
                    _buildOptionButton(context, homeProvider, "Add List"),
                    _buildOptionButton(context, homeProvider, "Add Note"),
                    _buildOptionButton(context, homeProvider, "Add Todo", highlight: true),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            Positioned(
              bottom: 60,
              right: 20,
              child: GestureDetector(
                onTap: () => homeProvider.toggleAddOptions(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD86628),
                    borderRadius: BorderRadius.circular(homeProvider.showAddOptions ? 12:28),
                  ),
                  child: Icon(
                    homeProvider.showAddOptions ? Icons.close : Icons.add,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, HomeProvider provider, String label, {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: highlight ? const Color(0xFFD86628) : Colors.white,
          foregroundColor: highlight ? Colors.white : const Color(0xFFD86628),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: highlight
                ? BorderSide.none
                : const BorderSide(color: Color(0xFFD86628)),
          ),
          elevation: 4,
          shadowColor: Colors.black26,
        ),
        onPressed: () {
          provider.selectOption(context, label);
        },
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

