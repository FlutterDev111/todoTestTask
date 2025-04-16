import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todotask/core/di/injection_container.dart';
import 'package:todotask/core/routes/app_pages.dart';
import 'package:todotask/core/routes/app_routes.dart';
import 'package:todotask/core/theme/app_theme.dart';
import 'core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize storage service
  await Get.putAsync(() => StorageService().init());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
