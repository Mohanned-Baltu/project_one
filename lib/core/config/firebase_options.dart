import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'dummy_api_key_for_testing',
      appId: '1:1234567890:android:1234567890abcdef',
      messagingSenderId: '1234567890',
      projectId: 'game-hub-testing',
    );
  }
}
