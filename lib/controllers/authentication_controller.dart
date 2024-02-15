import 'package:firebase_auth/firebase_auth.dart';
import 'package:placement_notifier/configs/push_notifications_config.dart';
import 'package:signals/signals.dart';

class AuthenticationController {
  final currentlyLoggedInUser = signal<User?>(null);

  late final isLoggedIn = computed(() => currentlyLoggedInUser() != null);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void listenToAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        currentlyLoggedInUser.value = null;
      } else {
        currentlyLoggedInUser.value = user;
      }
    });
  }

  Future<void> handleGoogleSignin() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await _auth.signInWithProvider(googleAuthProvider);
      await PushNotifications.firebaseMessaging.subscribeToTopic("placement");
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    PushNotifications.firebaseMessaging.unsubscribeFromTopic("placement");
  }
}

final auth = AuthenticationController();
