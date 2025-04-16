import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/storage_service.dart';
import '../../data/models/user_model.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final storage = StorageService.to;
  
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;
  late TextEditingController dateController;
  late TextEditingController phoneController;

  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;
  final isLoading = false.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    initializeControllers();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    if (storage.isLoggedIn()) {
      currentUser.value = storage.getUser();
      Get.offAllNamed(AppRoutes.home);
    }
  }

  void initializeControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
    dateController = TextEditingController();
    phoneController = TextEditingController();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    dateController.dispose();
    phoneController.dispose();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    fullNameController.clear();
    dateController.clear();
    phoneController.clear();
  }

  void navigateToSignup() {
    Get.delete<AuthController>();
    Get.to(() => const SignupPage(), binding: BindingsBuilder(() {
      Get.put(AuthController());
    }));
  }

  void navigateToLogin() {
    Get.delete<AuthController>();
    Get.to(() => const LoginPage(), binding: BindingsBuilder(() {
      Get.put(AuthController());
    }));
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of birth is required';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      // Commenting out authentication for now
      // await Future.delayed(const Duration(seconds: 2));
      // final user = UserModel(
      //   fullName: "Demo User",
      //   email: emailController.text,
      //   dateOfBirth: "01/01/1990",
      //   phoneNumber: "+91 1234567890"
      // );
      // await storage.saveUser(user);
      // await storage.saveIsLoggedIn(true);
      // if (rememberMe.value) {
      //   await storage.saveToken("mock_token");
      // }
      // currentUser.value = user;
      
      clearControllers();
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      // Commenting out authentication for now
      // final user = UserModel(
      //   fullName: fullNameController.text,
      //   email: emailController.text,
      //   dateOfBirth: dateController.text,
      //   phoneNumber: phoneController.text,
      // );
      // await Future.delayed(const Duration(seconds: 2));
      // await storage.saveUser(user);
      // await storage.saveIsLoggedIn(true);
      // await storage.saveToken("mock_token");
      // currentUser.value = user;
      
      clearControllers();
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registration failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await storage.clearAll();
      currentUser.value = null;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Logout failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 