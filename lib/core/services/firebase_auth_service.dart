import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/auth/data/models/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String dateOfBirth,
  }) async {
    try {
      // First check if email is already in use
      final methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        throw Exception('Email is already in use');
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Failed to create user');
      }

      // Update user profile
     // await userCredential.user?.updateDisplayName(fullName);

      // Convert Firebase User to our UserModel
      return UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        fullName: "fullName",
        phoneNumber: "phoneNumber",
        dateOfBirth: "dateOfBirth",
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw Exception('The password provided is too weak');
        case 'email-already-in-use':
          throw Exception('The account already exists for that email');
        case 'network-request-failed':
          throw Exception('Network error. Please check your internet connection');
        default:
          throw Exception('Failed to sign up: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  // Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Failed to sign in');
      }

      // Convert Firebase User to our UserModel
      return UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        fullName: userCredential.user!.displayName ?? '',
        phoneNumber: userCredential.user!.phoneNumber ?? '',
        dateOfBirth: '', // This will be empty as it's not part of Firebase Auth
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found for that email');
        case 'wrong-password':
          throw Exception('Wrong password provided');
        case 'network-request-failed':
          throw Exception('Network error. Please check your internet connection');
        default:
          throw Exception('Failed to sign in: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  // Sign in with Google
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Google sign in aborted');

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw Exception('Failed to sign in with Google');
      }

      // Convert Firebase User to our UserModel
      return UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        fullName: userCredential.user!.displayName ?? '',
        phoneNumber: userCredential.user!.phoneNumber ?? '',
        dateOfBirth: '', // This will be empty as it's not part of Firebase Auth
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'network-request-failed':
          throw Exception('Network error. Please check your internet connection');
        default:
          throw Exception('Failed to sign in with Google: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to sign in with Google: ${e.toString()}');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found with that email');
        case 'network-request-failed':
          throw Exception('Network error. Please check your internet connection');
        default:
          throw Exception('Failed to send password reset email: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to send password reset email: ${e.toString()}');
    }
  }

  // Get current user as UserModel
  Future<UserModel?> getCurrentUserModel() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    return UserModel(
      id: user.uid,
      email: user.email!,
      fullName: user.displayName ?? '',
      phoneNumber: user.phoneNumber ?? '',
      dateOfBirth: '', // This will be empty as it's not part of Firebase Auth
    );
  }
} 