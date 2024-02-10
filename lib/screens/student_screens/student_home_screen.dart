import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:placement_notifier/controllers/authentication_controller.dart';
import 'package:placement_notifier/controllers/database_controller.dart';
import 'package:placement_notifier/models/placement.dart';
import 'package:placement_notifier/screens/student_screens/placement_details_screen.dart';

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
      body: FutureBuilder(
        future: db.getPaginatedNotifications(10),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.stackTrace);
            return Center(
              child: Text("Error fetching notifications ${snapshot.error}"),
            );
          }
          final notifications = snapshot.data as List<Placement>;
          if (notifications.isEmpty) {
            return const Center(
              child: Text("No notifications found"),
            );
          } else {
            return LiquidPullToRefresh(
              onRefresh: () {
                setState(() {});
                return Future.value();
              },
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (_, index) {
                  final notification = notifications[index];
                  print(notification);
                  return SizedBox(
                    child: ListTile(
                      title: Text(notification.companyName),
                      subtitle: Text(notification.jobRole),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(notification.imageUrl),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return PlacementDetailsScreen(
                                  placement: notification);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
