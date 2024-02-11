import 'package:firebase_auth/firebase_auth.dart';
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
      _auth.signInWithProvider(googleAuthProvider);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final auth = AuthenticationController();