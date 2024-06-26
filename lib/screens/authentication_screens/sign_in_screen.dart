import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:placement_notifier/controllers/authentication_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PlaceMe By CEAL',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/animation2.json"),
            const SizedBox(
              height: 70,
            ),
            ElevatedButton(
              onPressed: () {
                auth.handleGoogleSignin().catchError((err) {
                  print("ran here");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: $err"),
                    ),
                  );
                });
              },
              child: const SizedBox(
                // width: 100,
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/google_icon.png"),
                      height: 18.0,
                      width: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24, right: 8),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "(Sign in with Institution Mail)",
              // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
