import 'package:flutter/material.dart';
import 'package:placement_notifier/models/placement.dart';
import 'package:placement_notifier/screens/student_screens/placement_details_screen.dart';

class PlacementListTile extends StatefulWidget {
  const PlacementListTile({super.key, required this.notification});

  final Placement notification;

  @override
  State<PlacementListTile> createState() => _PlacementListTileState();
}

class _PlacementListTileState extends State<PlacementListTile> {
  late String timestamp;

  @override
  Widget build(BuildContext context) {
    if (widget.notification.timestamp.day == DateTime.now().day) {
      timestamp = "Today";
    } else if (widget.notification.timestamp.day == DateTime.now().day - 1) {
      timestamp = "Yesterday";
    } else {
      timestamp =
          "${widget.notification.timestamp.day}/${widget.notification.timestamp.month}/${widget.notification.timestamp.year}";
    }
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
                widget.notification.imageUrl!,
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
              widget.notification.companyName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip,
              ),
            ),
            subtitle: Text(
              widget.notification.jobRole,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PlacementDetailsScreen(
                      placement: widget.notification,
                    );
                  },
                ),
              );
            },
            //show timestamp
            trailing: Text(
              timestamp,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
