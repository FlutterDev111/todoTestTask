import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_pages.dart';
import 'core/services/storage_service.dart';
import 'controllers/onboarding_controller.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/home/presentation/controllers/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize storage service
  final storageService = await StorageService().init();
  
  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        ChangeNotifierProvider(
          create: (context) => AuthController(
            storage: context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => OnboardingController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE17055)),
        useMaterial3: true,
      ),
      initialRoute: AppPages.initial,
      onGenerateRoute: AppPages.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
