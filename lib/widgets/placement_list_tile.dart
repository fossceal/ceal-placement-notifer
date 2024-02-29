import 'package:flutter/material.dart';
import 'package:placement_notifier/models/placement.dart';
import 'package:placement_notifier/screens/student_screens/placement_details_screen.dart';

class PlacementListTile extends StatelessWidget {
  const PlacementListTile({super.key, required this.notification});

  final Placement notification;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
              backgroundColor: Colors.red,
              radius: 30,
              backgroundImage: NetworkImage(
                notification.imageUrl!,
              ),
              onBackgroundImageError: (exception, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Error loading image"),
                  ),
                );
              },
            ),
            title: Text(
              notification.companyName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(notification.jobRole),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PlacementDetailsScreen(
                      placement: notification,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
