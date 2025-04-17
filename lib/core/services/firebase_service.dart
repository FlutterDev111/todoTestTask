import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyBNET5gzsS4RFHHwHTzCv5A7UEO1s9NQPE',
        appId: '1:846790683902:android:74bfe00fab3be2364889af',
        messagingSenderId: '846790683902',
        projectId: 'todotesttask-213ab',
        storageBucket: 'todotesttask-213ab.firebasestorage.app',
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const FirebaseOptions(
        apiKey: 'YOUR-IOS-API-KEY',
        appId: 'YOUR-IOS-APP-ID',
        messagingSenderId: 'YOUR-SENDER-ID',
        projectId: 'YOUR-PROJECT-ID',
        storageBucket: 'YOUR-STORAGE-BUCKET',
        iosClientId: 'YOUR-IOS-CLIENT-ID',
        iosBundleId: 'com.example.todotask',
      );
    }
    throw UnsupportedError('Unsupported platform: ${defaultTargetPlatform}');
  }
} 