import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signals/signals.dart';

class AuthenticationController {
  final currentlyLoggedInUser = signal<User?>(null);

  late final isLoggedIn = computed(() => currentlyLoggedInUser() != null);

  void listenToAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        currentlyLoggedInUser.value = null;
      } else {
        print('User is signed in!');
        currentlyLoggedInUser.value = user;
      }
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider
          .setCustomParameters({'login_hint': 'user@ceattingal.ac.in'});

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    // Trigger the authentication flow
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

final auth = AuthenticationController();
