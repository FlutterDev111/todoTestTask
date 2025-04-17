import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todotask/core/services/firebase_auth_service.dart';
import 'package:todotask/core/utils/validators.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/storage_service.dart';
import '../../data/models/user_model.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = Get.find<FirebaseAuthService>();
  final StorageService storage;
  
  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  // Form validation
  final formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool rememberMe = false.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  // Validation methods
  String? validateEmail(String? value) => Validators.validateEmail(value);
  String? validatePassword(String? value) => Validators.validatePassword(value);
  String? validateFullName(String? value) => Validators.validateFullName(value);
  String? validatePhoneNumber(String? value) => Validators.validatePhoneNumber(value);
  String? validateDateOfBirth(String? value) => Validators.validateDateOfBirth(value);

  AuthController({required this.storage}) {
    checkLoginStatus();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    _authService.authStateChanges.listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        // Convert Firebase User to our UserModel
        final userModel = UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          fullName: firebaseUser.displayName ?? '',
          phoneNumber:  '',
          dateOfBirth: '', // This will be empty as it's not part of Firebase Auth
        );
        
        currentUser.value = userModel;
        storage.saveUser(userModel);
        Get.offAllNamed('/home');
      } else {
        currentUser.value = null;
       // storage.clearUser();
      }
    });
  }

  void checkLoginStatus() async {
    final user = await _authService.getCurrentUserModel();
    if (user != null) {
      currentUser.value = user;
    }
  }

  void initializeControllers() {
    emailController.clear();
    passwordController.clear();
    fullNameController.clear();
    dateOfBirthController.clear();
    phoneNumberController.clear();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    dateOfBirthController.dispose();
    phoneNumberController.dispose();
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
    dateOfBirthController.clear();
    phoneNumberController.clear();
  }

  void navigateToSignup(BuildContext context) {
    clearControllers();
    Get.toNamed(AppRoutes.signup);
  }

  void navigateToLogin(BuildContext context) {
    clearControllers();
    Get.toNamed(AppRoutes.login);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool value) {
    rememberMe.value = value;
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void setCurrentUser(UserModel? user) {
    currentUser.value = user;
  }

  Future<void> signInWithEmailAndPassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _authService.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Navigation will be handled by the auth state listener
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _authService.signUpWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
        fullName: fullNameController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        dateOfBirth: dateOfBirthController.text.trim(),
      );

      // Navigation will be handled by the auth state listener
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _authService.signInWithGoogle();

      // Navigation will be handled by the auth state listener
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      // State will be handled by the auth state listener
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> forgotPassword() async {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      await _authService.resetPassword(emailController.text.trim());
      Get.snackbar(
        'Success',
        'Password reset email sent. Please check your inbox.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
} 