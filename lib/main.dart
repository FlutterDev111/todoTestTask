import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todotask/core/routes/app_routes.dart';
import 'package:todotask/core/services/storage_service.dart';
import 'package:todotask/features/auth/presentation/controllers/auth_controller.dart';
import 'package:todotask/features/auth/presentation/pages/login_page.dart';
import 'package:todotask/features/auth/presentation/pages/signup_page.dart';
import 'package:todotask/features/home/presentation/pages/home_page.dart';
import 'package:todotask/core/services/firebase_auth_service.dart';

import 'core/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Wait for Firebase to be ready
    await Future.delayed(const Duration(seconds: 1));

    // Initialize services
    final storageService = await Get.putAsync(() => StorageService().init());
    Get.put(FirebaseAuthService());
    
    // Initialize controllers
    Get.put(AuthController(storage: storageService));

    runApp(const MyApp());
  } catch (e) {
    debugPrint('Error initializing app: $e');
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Error initializing app',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  e.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Try to restart the app
                    main();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.login,
      getPages: [
        GetPage(name: AppRoutes.login, page: () => LoginPage()),
        GetPage(name: AppRoutes.signup, page: () => SignupPage()),
        GetPage(name: AppRoutes.home, page: () => HomePage()),
      ],
    );
  }
}
