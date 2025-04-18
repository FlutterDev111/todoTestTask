import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todotask/core/services/firebase_auth_service.dart';

import '../../data/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuthService _authService;
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

  AuthProvider([FirebaseAuthService? authService]) 
      : _authService = authService ?? FirebaseAuthService();

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

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword() async {
    if (!_formKey.currentState!.validate()) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authService.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      _currentUser = user;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign out
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signOut();
      _currentUser = null;
    } catch (e) {
      _errorMessage = e.toString();
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

  Future<void> signUp() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signUpWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
        fullName: fullNameController.text,
        phoneNumber: phoneController.text,
        dateOfBirth: dateOfBirthController.text,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}