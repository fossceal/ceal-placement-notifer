import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placement_notifier/configs/push_notifications_config.dart';
import 'package:placement_notifier/controllers/authentication_controller.dart';
import 'package:placement_notifier/firebase_options.dart';
import 'package:placement_notifier/router.dart';
import 'package:placement_notifier/screens/admin_screens/admin_dashboard_screen.dart';
import 'package:placement_notifier/screens/admin_screens/admin_home_screen.dart';
import 'package:placement_notifier/screens/authentication_screens/sign_in_screen.dart';
import 'package:placement_notifier/screens/student_screens/student_home_screen.dart';
import 'package:signals/signals_flutter.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  print("notification received $message");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth.listenToAuthChanges();
  await PushNotifications.init();
  PushNotifications.localNotiInit();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData,
      );
    }
  });
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(
    const MyApp(),
  );
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
            "anumarvelz57@gmail.com") {
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
