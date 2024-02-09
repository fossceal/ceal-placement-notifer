import 'package:flutter/material.dart';
import 'package:placement_notifier/controllers/database_controller.dart';
import 'package:placement_notifier/models/placement.dart';
import 'package:placement_notifier/screens/admin_screens/edit_placement_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // void init() {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (_, index) {
              final notification = notifications[index];
              print(notification);
              return ListTile(
                title: Text(notification.companyName),
                subtitle: Text(notification.jobRole),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await db.deleteNotification(
                        notifications[index].id, notification.imageUrl);
                    setState(() {});
                  },
                ),
                leading: Image.network(notification.imageUrl),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EditPlacementScreen(
                          id: notification.id,
                          companyName: notification.companyName,
                          jobRole: notification.jobRole,
                          jobDescription: notification.jobDescription,
                          applyLink: notification.applyLink,
                          logo: notification.imageUrl,
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}