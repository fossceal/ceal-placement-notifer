import 'package:flutter/material.dart';
import 'package:placement_notifier/screens/admin_screens/admin_add_placement_screen.dart';
import 'package:placement_notifier/screens/admin_screens/admin_dashboard_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PlaceMe Admin Panel"),
      ),
      body: const AdminDashboardScreen(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AdminAddPlacementScreen();
          }));
        },
      ),
    );
  }
}
