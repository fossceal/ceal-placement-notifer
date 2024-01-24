import 'package:ceal_placement_notifier/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

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
