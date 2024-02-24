import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:placement_notifier/controllers/authentication_controller.dart';
import 'package:placement_notifier/controllers/database_controller.dart';
import 'package:placement_notifier/main.dart';
import 'package:placement_notifier/models/placement.dart';
import 'package:placement_notifier/screens/admin_screens/admin_home_screen.dart';
import 'package:placement_notifier/screens/authentication_screens/sign_in_screen.dart';
import 'package:placement_notifier/screens/student_screens/placement_details_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  String token = "";
  Future<void> firebaseBackgroundMessage(RemoteMessage message) async {}

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(firebaseBackgroundMessage);
    FirebaseMessaging.instance.getToken().then((value) {
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
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const InitialiserScreen();
                  }), (route) => false);
                }).catchError((err) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: err));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return const SignInScreen();
                    }),
                  );
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
        title: const Text(
          "PlaceMe By CEAL",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await db.getAllAdmins().then((List<dynamic> admins) {
                if (admins.contains(auth.currentlyLoggedInUser.value?.email)) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const AdminHomeScreen();
                  }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("You are not an admin"),
                    ),
                  );
                }
              });
            },
            icon: const Icon(Icons.admin_panel_settings),
          ),
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
            return Center(
              child: Text("Error fetching notifications ${snapshot.error}"),
            );
          }
          final notifications = snapshot.data as List<Placement>;
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.refresh,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "No notifications found",
                  ),
                ],
              ),
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
                  return SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        borderOnForeground: true,
                        color: Colors.orange[50],
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              notification.imageUrl,
                            ),
                            backgroundColor: Colors.red,
                            radius: 30,
                          ),
                          title: Text(
                            notification.companyName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(notification.jobRole),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return PlacementDetailsScreen(
                                  placement: notification,
                                );
                              },
                            ));
                          },
                        ),
                      ),
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
