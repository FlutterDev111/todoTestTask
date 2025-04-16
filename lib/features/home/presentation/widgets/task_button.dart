import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todotask/features/home/presentation/controllers/home_controller.dart';

class TaskTypeButton extends StatelessWidget {
  final String? text;

  const TaskTypeButton({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<HomeController>().selectedCategory == text;

   return GestureDetector(
      onTap: () {
        context.read<HomeController>().changeCategory(text??"");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: (selected??false) ? const Color(0xFFD86628) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD4D4D4)),
          boxShadow:(selected??false)
              ? [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]
              : [],
        ),
        child: Text(
          (text??""),
          style: TextStyle(
            color: (selected??false) ? Colors.white : Color(0xff9A9A9A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
