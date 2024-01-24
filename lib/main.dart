import 'package:ceal_placement_notifier/config/firebase_config.dart';
import 'package:ceal_placement_notifier/controllers/authentication_controller.dart';
import 'package:ceal_placement_notifier/router.dart';
import 'package:ceal_placement_notifier/screens/admin_screens/admin_dashboard_screen.dart';
import 'package:ceal_placement_notifier/screens/admin_screens/admin_home_screen.dart';
import 'package:ceal_placement_notifier/screens/authentication_screens/sign_in_screen.dart';
import 'package:ceal_placement_notifier/screens/student_screens/student_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseFirebase();
  auth.listenToAuthChanges();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

class InitialiserScreen extends StatelessWidget {
  const InitialiserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      if (auth.isLoggedIn.value) {
        if (auth.currentlyLoggedInUser.value!.email ==
            "20cs14@ceattingal.ac.in") {
          return const AdminHomeScreen(
            child: AdminDashboardScreen(),
          );
        } else {
          return const StudentHomeScreen();
        }
      } else {
        return const SignInScreen();
      }
    });
  }
}
