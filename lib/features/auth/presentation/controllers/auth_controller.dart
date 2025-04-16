import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/storage_service.dart';
import '../../data/models/user_model.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';

class AuthController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final StorageService storage;
  
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;
  late TextEditingController dateController;
  late TextEditingController phoneController;

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isLoading = false;
  UserModel? _currentUser;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get rememberMe => _rememberMe;
  bool get isLoading => _isLoading;
  UserModel? get currentUser => _currentUser;

  AuthController({required this.storage}) {
    initializeControllers();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    if (storage.isLoggedIn()) {
      _currentUser = storage.getUser();
      notifyListeners();
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
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    fullNameController.clear();
    dateController.clear();
    phoneController.clear();
  }

  void navigateToSignup(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.signup);
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@') || !value.contains('.')) {
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
    // Simple phone number validation
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      setLoading(true);
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
      // if (rememberMe) {
      //   await storage.saveToken("mock_token");
      // }
      // setCurrentUser(user);
      
      clearControllers();
      notifyListeners();
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      setLoading(true);
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
      // setCurrentUser(user);
      
      clearControllers();
      notifyListeners();
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await storage.clearAll();
      _currentUser = null;
      notifyListeners();
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
} 