import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:placement_notifier/models/placement.dart';

class PlacementDetailsScreen extends StatelessWidget {
  const PlacementDetailsScreen({super.key, required this.placement});

  final Placement placement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Placement Details"),
      ),
      //show all the details in a beautiful way
      body: Column(
        children: [
          Image.network(placement.imageUrl),
          Text(placement.companyName),
          Text(placement.jobRole),
          Text(placement.jobDescription),
          Text(placement.applyLink),
        ],
      ),
    );
  }
}
