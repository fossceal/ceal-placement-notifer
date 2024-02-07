import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:placement_notifier/controllers/authentication_controller.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  String token = "";
  Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
    print("Home Screen");
    print(message.data["title"]);
    print(message.data["body"]);
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(firebaseBackgroundMessage);
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      setState(() {
        token = value!;
      });
    });
    super.initState();
  }

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you Sure?"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are about to logout'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Continue'),
              onPressed: () async {
                await auth.signOut().then((value) {
                  Navigator.of(context).pop();
                }).catchError((err) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: err));
                  Navigator.of(context).pop();
                });
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ceal Placement Notifier"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
