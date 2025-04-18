import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todotask/core/services/firebase_auth_service.dart';
import 'package:todotask/core/services/storage_service.dart';

import '../../data/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuthService _authService;
  final StorageService _storageService;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  String? _errorMessage;
  UserModel? _currentUser;

  AuthProvider(this._authService, this._storageService);

  // Getters
  GlobalKey<FormState> get formKey => _formKey;
  // TextEditingController get emailController => emailController;
  // TextEditingController get passwordController => passwordController;
  // TextEditingController get fullNameController => fullNameController;
  // TextEditingController get phoneController => phoneController;
  // TextEditingController get dateOfBirthController => dateOfBirthController;
  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get rememberMe => _rememberMe;
  String? get errorMessage => _errorMessage;
  UserModel? get currentUser => _currentUser;

  // Dispose method
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  // Auth state listener

  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Toggle remember me
  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\+?[\d\s-]+$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth';
    }
    return null;
  }

  Future<void> saveUserSession(UserModel user) async {
    await _storageService.setString('user_id', user.id);
    await _storageService.setString('user_email', user.email);
    await _storageService.setString('user_name', user.fullName);
    if (_rememberMe) {
      await _storageService.setBool('remember_me', true);
    }
  }

  // Sign in with email and password
  Future<void> signIn(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authService.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      _currentUser = user;
      await saveUserSession(user);

      // Navigate to home page and remove all previous routes
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authService.signInWithGoogle();
      _currentUser = user;
      await saveUserSession(user);

      // Navigate to home page and remove all previous routes
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign out
  Future<void> signOut(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signOut();
      await _storageService.clear();
      _currentUser = null;

      // Navigate to login page and remove all previous routes
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.resetPassword(email);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authService.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
        fullName: fullNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        dateOfBirth: dateOfBirthController.text.trim(),
      );

      _currentUser = user;
      await saveUserSession(user);

      // Navigate to home page and remove all previous routes
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}