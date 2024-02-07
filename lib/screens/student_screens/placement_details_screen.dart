import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PlacementDetailsScreen extends StatelessWidget {
  const PlacementDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Placement Details"),
      ),
      body: Center(
        child: Text(
          data.data.toString(),
        ),
      ),
    );
  }
}
