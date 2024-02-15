import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:placement_notifier/configs/push_notifications_config.dart';
import 'package:placement_notifier/controllers/authentication_controller.dart';
import 'package:placement_notifier/firebase_options.dart';
import 'package:placement_notifier/screens/authentication_screens/sign_in_screen.dart';
import 'package:placement_notifier/screens/student_screens/student_home_screen.dart';
import 'package:signals/signals_flutter.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {}

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
  await dotenv.load(fileName: ".env");
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlaceMe By CEAL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: const InitialiserScreen(),
    );
  }
}

class InitialiserScreen extends StatelessWidget {
  const InitialiserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      if (auth.isLoggedIn.value) {
        return const StudentHomeScreen();
      } else {
        return const SignInScreen();
      }
    });
  }
}
